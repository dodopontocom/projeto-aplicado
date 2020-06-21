resource "random_id" "instance_id_2" {
  byte_length = 3
}
/*
resource "google_compute_address" "static_ip_address-2" {
  name = "static-ip-address-2"
}
*/

resource "google_compute_instance" "instance_2" {
  name         = "vm-tf-${random_id.instance_id_2.hex}"
  machine_type = var.machine_type
  depends_on  = [google_compute_subnetwork.subnet]
  zone         = var.zone

  labels       = {
    "env" = "${var.compute_instance_environment}"
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
  
  network_interface {
    subnetwork = var.subnet_name

    access_config {
      // Adicionar um IP externo para a VM
      nat_ip = google_compute_address.static_ip_address.address
    }
  }

  // Permitir que IPs externos a network ecessem a VM
  tags = ["http-server", "https-server"]
}