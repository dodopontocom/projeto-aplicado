variable ssd_name { }
variable zone { }

resource "google_compute_disk" "home_mount_disk" {
    name                        = var.ssd_name
    type                        = "pd-ssd"
    size                        = "10"
    zone                        = var.zone
    physical_block_size_bytes   = 4096
}