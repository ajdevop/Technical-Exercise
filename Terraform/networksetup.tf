#creating vpc
resource "aws_vpc" "kafkaVpc" {

  cidr_block = "${var.cidr_block_vpc}"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
}

#creating main public subnet
resource "aws_subnet" "public_subnet-us-west-1a"
{

  vpc_id="${aws_vpc.kafkaVpc.id}"
  cidr_block = "${var.cidr_block_public}"
  map_public_ip_on_launch ="true"
  availability_zone = "${var.public_subnet_availabilityzone_a}"
  tags
  {
    Name = "public-subnet"
  }
}


resource "aws_internet_gateway" "igw"
{

  vpc_id="${aws_vpc.kafkaVpc.id}"
  tags
  {
    Name="igw"
  }
}

resource "aws_route_table" "public-subnet-route-table"
{
  vpc_id="${aws_vpc.kafkaVpc.id}"
  route
  {
    cidr_block="0.0.0.0/0"
    gateway_id="${aws_internet_gateway.igw.id}"
  }
  tags
  {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public-subnet-route-us-west-1a"
{
  subnet_id = "${aws_subnet.public_subnet-us-west-1a.id}"
  route_table_id="${aws_route_table.public-subnet-route-table.id}"
}
