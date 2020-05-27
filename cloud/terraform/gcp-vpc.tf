//Criar Virtual Private Cloud
resource "google_compute_network" "vpc" {
    name                    = var.vpc_name
    auto_create_subnetworks = false
}

//Criar subnets
resource "google_compute_subnetwork" "subnet" {
    name            = var.subnet_name
    ip_cidr_range   = var.subnet_cidr
    network         = var.vpc_name
    depends_on      = [google_compute_network.vpc]
    region          = var.region
}

//Criar regra de firewall
resource "google_compute_firewall" "firewall" {
    name        = var.firewall_name
    network     = google_compute_network.vpc.name
    depends_on  = [google_compute_subnetwork.subnet]

    allow {
        protocol    = "icmp"
    }
    allow {
        protocol    = "tcp"
        ports       = ["22"]
    }

    source_ranges   = ["0.0.0.0/0"]
}