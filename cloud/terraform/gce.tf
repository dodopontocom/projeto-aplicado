resource "random_id" "instance_id" {
  byte_length = 3
}

resource "google_compute_address" "static_ip_address" {
  name = "static-ip-address"
}

resource "google_compute_instance" "gcp_lab_instance" {
  name         = "vm-tf-${random_id.instance_id.hex}"
  machine_type = var.machine_type
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
  
  network_interface {
    network = var.vpc_name

    access_config {
      // Include this section to give the VM an external ip address
      nat_ip = google_compute_address.static_ip_address.address
    }
  }

  // Apply the firewall rule to allow external IPs to access this instance
  tags = ["http-server", "https-server"]
}