variable "project_id" { }
variable "region" { }
variable "key" { }
variable "vpc_name" { }
variable "tf_backend_bucket_name" { }
variable "service_list" {
  type  = list
}
variable "subnet_name" { }
variable "subnet_cidr" { }
variable "firewall_name" { }
variable "machine_type" { }
variable "zone" { }
variable "compute_instance_environment" { }
variable "ubuntu_image" { }
variable "centos_image" { }
variable "devops_sa_email" { }
