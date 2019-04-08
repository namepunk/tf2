resource "aws_vpc" "T2_VPC" {
  cidr_block = "${var.VPC_CIDR}"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project}_VPC"
  }
}

resource "aws_eip" "T2_nat_eip" {
  vpc      = true
  tags = {
    Name = "${var.project}_nat_eip"
  }

}

resource "aws_internet_gateway" "T2_gw" {
  vpc_id = "${aws_vpc.T2_VPC.id}"
  tags = {
    Name = "${var.project}_gw"
  }
}

resource "aws_nat_gateway" "T2_nat_gw" {
  allocation_id = "${aws_eip.T2_nat_eip.id}"
  subnet_id     = "${aws_subnet.T2_public.id}"
  tags = {
    Name = "${var.project}_nat_gw"
  }
}



resource "aws_route_table" "T2_route_pub" {
  vpc_id = "${aws_vpc.T2_VPC.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.T2_gw.id}"
  }
  
  tags = {
    Name = "${var.project}_route_pub"
  }
}

resource "aws_route_table" "T2_route_priv" {
  vpc_id = "${aws_vpc.T2_VPC.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.T2_nat_gw.id}"
  }

  tags = {
    Name = "${var.project}_route_priv"
  }
}


resource "aws_subnet" "T2_public" {
  vpc_id     = "${aws_vpc.T2_VPC.id}"
  cidr_block = "${var.subnet_pub}"
  availability_zone = "${var.zone1}"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.project}_public1"
  }
}

resource "aws_subnet" "T2_public2" {
  vpc_id     = "${aws_vpc.T2_VPC.id}"
  cidr_block = "${var.subnet_pub2}"
  availability_zone = "${var.zone2}"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${var.project}_public2"
  }
}


resource "aws_route_table_association" "T2_pub_ass" {
  subnet_id      = "${aws_subnet.T2_public.id}"
  route_table_id = "${aws_route_table.T2_route_pub.id}"
}

resource "aws_subnet" "T2_private1" {
  vpc_id     = "${aws_vpc.T2_VPC.id}"
  cidr_block = "${var.subnet_pr1}"
  availability_zone = "${var.zone1}"
  tags = {
    Name = "${var.project}_private1"
  }
}

resource "aws_route_table_association" "T2_pr1_ass" {
  subnet_id      = "${aws_subnet.T2_private1.id}"
  route_table_id = "${aws_route_table.T2_route_priv.id}"
}

resource "aws_subnet" "T2_private2" {
  vpc_id     = "${aws_vpc.T2_VPC.id}"
  cidr_block = "${var.subnet_pr2}"
  availability_zone = "${var.zone2}"
  tags = {
    Name = "${var.project}_private2"
  }
}

resource "aws_route_table_association" "T2_pr2_ass" {
  subnet_id      = "${aws_subnet.T2_private2.id}"
  route_table_id = "${aws_route_table.T2_route_priv.id}"
}


