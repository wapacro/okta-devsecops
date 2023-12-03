resource "aws_default_vpc" "network_default_vpc" {}

resource "aws_default_subnet" "network_default_subnet_az1" {
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
}

resource "aws_default_subnet" "network_default_subnet_az2" {
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true
}

resource "aws_default_subnet" "network_default_subnet_az3" {
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "network_private_subnet_az1" {
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = false
  vpc_id                  = aws_default_vpc.network_default_vpc.id
  cidr_block              = "172.31.48.0/20"
}

resource "aws_eip" "network_elastic_ip" {}

resource "aws_nat_gateway" "network_nat_gateway" {
  subnet_id         = aws_default_subnet.network_default_subnet_az1.id
  connectivity_type = "public"
  allocation_id     = aws_eip.network_elastic_ip.id
}

resource "aws_route_table" "network_private_route_table" {
  vpc_id = aws_default_vpc.network_default_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.network_nat_gateway.id
  }
}

resource "aws_route_table_association" "network_private_route_table_association" {
  subnet_id      = aws_subnet.network_private_subnet_az1.id
  route_table_id = aws_route_table.network_private_route_table.id
}
