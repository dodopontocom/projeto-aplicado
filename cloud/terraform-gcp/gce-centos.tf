resource "random_id" "centos_instance_id" {
  byte_length = 3
}

resource "google_compute_address" "static_ip_address_centos" {
  name = "centos-static-ip-address"
}

/*resource "google_compute_address" "internal_centos" {
  name = "centos-internal-ip-address"
  subnetwork   = var.subnet_name
  address_type = "INTERNAL"
  address      = "10.10.0.3"
  region       = var.region
}*/

resource "google_compute_instance" "centos_instance" {
  name         = "vm-tf-${random_id.centos_instance_id.hex}"
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

  metadata = {
    LDAP_ADMIN_PASS = var.ldap_admin_pass
  }

  metadata_startup_script = file(var.centos_startup_script)
 
  network_interface {
    subnetwork = var.subnet_name
    network_ip = 10.10.0.3

    access_config {
      // Adicionar um IP externo para a VM
      nat_ip = google_compute_address.static_ip_address_centos.address
    }
  }

  // Permitir que IPs externos a network ecessem a VM
  tags = ["http-server", "https-server"]
}

//https://www.terraform.io/docs/providers/google/r/compute_address.html
