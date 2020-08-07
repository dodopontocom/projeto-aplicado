resource "random_id" "ubuntu_instance_id" {
  byte_length = 3
}

resource "google_compute_address" "static_ip_address_ubuntu" {
  name = "ubuntu-static-ip-address"
}

resource "google_compute_disk" "home_mount_disk" {
    name                        = var.ssd_name
    type                        = "pd-ssd"
    size                        = "10"
    zone                        = var.zone
    physical_block_size_bytes   = 4096
}

resource "google_compute_instance" "ubuntu_instance" {
  name         = "vm-tf-${random_id.ubuntu_instance_id.hex}"
  machine_type = var.machine_type
  depends_on  = [google_compute_subnetwork.subnet]
  zone         = var.zone

  labels       = {
    "env" = "${var.compute_instance_environment}"
  }

  attached_disk {
      source        = google_compute_disk.home_mount_disk.name
      device_name   = google_compute_disk.home_mount_disk.name
  }

  boot_disk {
    initialize_params {
      image = var.ubuntu_image
    }
  }

  allow_stopping_for_update = true
  scheduling {
    automatic_restart   = false
    preemptible = true
  }

  metadata_startup_script = file(var.ubuntu_startup_script)

  network_interface {
    subnetwork = var.subnet_name
    network_ip = "10.10.0.4"

    access_config {
      // Adicionar um IP externo para a VM
      nat_ip = google_compute_address.static_ip_address_ubuntu.address
    }
  }

  // Permitir que IPs externos a network ecessem a VM
  tags = ["http-server", "https-server"]
}