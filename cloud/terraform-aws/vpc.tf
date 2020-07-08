resource "aws_vpc" "vpc" {
  cidr_block = var.aws_cidr_block
  tags = {
    Name = "dev-vpc"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.aws_subnet_cidr_block
  availability_zone = var.aws_aval_zone

  tags = {
    Name = "dev-vpc"
  }
}

resource "aws_network_interface" "dev-network-interface" {
  subnet_id   = aws_subnet.subnet.id
  private_ips = ["172.16.10.100"]

  tags = {
    Name = "dev_network_interface"
  }
}