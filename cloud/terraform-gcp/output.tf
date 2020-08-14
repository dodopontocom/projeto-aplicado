/*output "ubuntu_ip" {
  value = module.ubuntu_client.network_interface.0.access_config.0.nat_ip
}
output "centos_ip" {
  value = google_compute_instance.centos_instance.network_interface.0.access_config.0.nat_ip
}*/