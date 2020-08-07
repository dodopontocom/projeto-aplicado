resource "google_compute_address" "internal_with_subnet_and_address" {
  name         = "my-internal-address"
  subnetwork   = var.subnet_name
  address_type = "INTERNAL"
  address      = "10.10.0.9"
  region       = var.region
}

resource "google_compute_address" "ext-address" {
  name         = "my-external-address"
}

resource "google_compute_instance" "instance3" {
  name         = "instance3"
  machine_type = var.machine_type
  depends_on  = [google_compute_subnetwork.subnet]
  zone         = var.zone

  labels       = {
    "env" = "${var.compute_instance_environment}"
  }
    
  boot_disk {
    initialize_params {
      image = var.centos_image
    }
  }
  
  allow_stopping_for_update = true
  scheduling {
    automatic_restart   = false
    preemptible = true
  }

  network_interface {
    subnetwork = var.subnet_name

    access_config {
      // Adicionar um IP externo para a VM
      nat_ip = google_compute_address.internal_with_subnet_and_address.address
    }
  }

  // Permitir que IPs externos a network ecessem a VM
  tags = ["http-server", "https-server"]
}