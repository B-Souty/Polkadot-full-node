resource "aws_vpc" "polkadot-poc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "polkadot-poc-vpc"
  }
}

resource "aws_subnet" "polkadot-poc-subnet" {
  vpc_id                  = aws_vpc.polkadot-poc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "polkadot-poc-subnet"
  }
}

resource "aws_internet_gateway" "polkadot-poc-igw" {
  vpc_id = aws_vpc.polkadot-poc.id

  tags = {
    Name = "polkadot-poc-igw"
  }
}

resource "aws_route_table" "polkadot-poc-rt" {
  vpc_id = aws_vpc.polkadot-poc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.polkadot-poc-igw.id
  }
}

resource "aws_route_table_association" "polkadot-poc-rt-assoc" {
  subnet_id      = aws_subnet.polkadot-poc-subnet.id
  route_table_id = aws_route_table.polkadot-poc-rt.id
}
