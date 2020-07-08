resource "aws_instance" "instance" {
  ami           = var.aws_ubuntu_ami_id
  instance_type = var.aws_instance_type
  depends_on  = [aws_network_interface.dev-network-interface]

  tags = {
    Name = "dev"
  }

  network_interface {
      network_interface_id = aws_network_interface.dev-network-interface.id
      device_index = 0
  }
}