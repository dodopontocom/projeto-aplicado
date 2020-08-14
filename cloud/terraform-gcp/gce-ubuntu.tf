module "ubuntu_client" {
    source                          = "./modules/vms"
    machine_type                    = var.machine_type
    zone                            = var.zone
    compute_instance_environment    = var.compute_instance_environment
    ubuntu_image                    = var.ubuntu_image
    ubuntu_startup_script           = var.ubuntu_startup_script
    subnet_name                     = var.subnet_name
    net_depends_on                  = [module.google_compute_subnetwork.subnet]
}