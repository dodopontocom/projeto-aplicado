variable "net_depends_on" { }
variable "machine_type" { }
variable "zone" { }
variable "compute_instance_environment" { }
variable "ubuntu_image" { }
variable "ubuntu_startup_script" { }
variable "subnet_name" { }

resource "random_id" "ubuntu_instance_id" {
  byte_length = 3
}

resource "google_compute_address" "static_ip_address_ubuntu" {
  name = "ubuntu-static-ip-address"
}

module "disk" {
    source  = "../storages"
    ssd_name    = "um_nome"
    zone    = "us-east1-a"
}

resource "google_compute_instance" "template_instance" {
  name         = "vm-tf-${random_id.ubuntu_instance_id.hex}"
  machine_type = var.machine_type
  depends_on  = [var.net_depends_on]
  zone         = var.zone

  labels       = {
    "env" = "${var.compute_instance_environment}"
  }

  attached_disk {
      source        = module.disk.my_ssd
      device_name   = module.disk.my_ssd
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