resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}
resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.pub1.id

  tags = {
    Name = "gw NAT"
  }
  depends_on = [aws_internet_gateway.gw]
}
  resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}
resource "aws_subnet" "pub1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "Main"
  }
}
resource "aws_subnet" "pub2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "Main"
  }
}
resource "aws_subnet" "pub3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-south-1c"

  tags = {
    Name = "Main"
  }
}
resource "aws_subnet" "pvt1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "Main"
  }
}
resource "aws_subnet" "pvt2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "Main"
  }
}
resource "aws_subnet" "pvt3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "ap-south-1c"

  tags = {
    Name = "Main"
  }
}
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}
resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat1.id
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.pub1.id
  route_table_id = aws_route_table.rt1.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.pub2.id
  route_table_id = aws_route_table.rt1.id
}
resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.pub3.id
  route_table_id = aws_route_table.rt1.id
}
resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.pvt1.id
  route_table_id = aws_route_table.rt2.id
}
resource "aws_route_table_association" "e" {
  subnet_id      = aws_subnet.pvt2.id
  route_table_id = aws_route_table.rt2.id
}
resource "aws_route_table_association" "f" {
  subnet_id      = aws_subnet.pvt3.id
  route_table_id = aws_route_table.rt2.id
}