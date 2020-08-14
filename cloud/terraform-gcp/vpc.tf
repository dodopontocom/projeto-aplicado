module "vpc" {
    source      = "./modules/networking"
    vpc_name    = var.vpc_name
    subnet_name = var.subnet_name
    subnet_cidr = var.subnet_cidr
    firewall_name   = var.firewall_name
    region          = var.region
}