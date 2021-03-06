resource "aws_route_table" "public-subnet-vpc-i-rt" {
  vpc_id = "${aws_vpc.vpc-with-internet.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet-gateway.id}"
  }

  tags {
    Name = "Public Subnet RT"
  }
}

resource "aws_route_table_association" "public-subnet-vpc-i-rt" {
  subnet_id = "${aws_subnet.public-subnet-vpc-i.id}"
  route_table_id = "${aws_route_table.public-subnet-vpc-i-rt.id}"
}

resource "aws_route_table" "private-subnet-vpc-i-rt" {
  vpc_id = "${aws_vpc.vpc-with-internet.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat.id}"
  }

  route {
    cidr_block = "10.0.0.0/24"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc-peering.id}"
  }

  tags {
    Name = "Private Subnet Route Table"
  }
}

resource "aws_route_table_association" "private-subnet-vpc-i-rt" {
  subnet_id = "${aws_subnet.private-subnet-vpc-i.id}"
  route_table_id = "${aws_route_table.private-subnet-vpc-i-rt.id}"
}

resource "aws_route_table" "private-subnet-vpc-ni-rt" {
  vpc_id = "${aws_vpc.vpc-no-internet.id}"

  route {
    cidr_block = "0.0.0.0/0"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc-peering.id}"
  }

  tags {
    Name = "Private Subnet Route Table in no internet vpc"
  }
}

resource "aws_route_table_association" "private-subnet-vpc-ni-rt" {
  subnet_id = "${aws_subnet.private-subnet-vpc-ni.id}"
  route_table_id = "${aws_route_table.private-subnet-vpc-ni-rt.id}"
}