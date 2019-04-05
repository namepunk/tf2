resource "aws_instance" "T2_bastion" {
  ami =  "${data.aws_ami.ami_ubuntu_18_04.id}"
  instance_type = "t2.micro"
  key_name = "Artem"
  subnet_id = "${aws_subnet.T2_public.id}"
  security_groups = ["${aws_security_group.T2_security_group.id}"]
  user_data       = "${data.template_file.bastion.rendered}"
  tags = {
    Name = "${var.project}_bastion"
  }
}

resource "aws_instance" "T2_app1" {
  ami = "${data.aws_ami.ami_ubuntu_18_04.id}"
  instance_type = "t2.micro"
  key_name = "Artem"
  subnet_id = "${aws_subnet.T2_private1.id}"
  security_groups = ["${aws_security_group.T2_security_group.id}"]
  user_data       = "${data.template_file.slave.rendered}"
  tags = {
    Name = "${var.project}_app1"
    role = "app"
  }
}


resource "aws_instance" "T2_app2" {
  ami = "${data.aws_ami.ami_ubuntu_18_04.id}"
  instance_type = "t2.micro"
  key_name = "Artem"
  subnet_id = "${aws_subnet.T2_private2.id}"
  security_groups = ["${aws_security_group.T2_security_group.id}"]
  user_data       = "${data.template_file.slave.rendered}"
  tags = {
    Name = "${var.project}_app2"
    role = "app"
  }
}


resource "aws_instance" "T2_mysql" {
  ami = "${data.aws_ami.ami_ubuntu_18_04.id}"
  instance_type = "t2.micro"
  key_name = "Artem"
  subnet_id = "${aws_subnet.T2_private2.id}"
  security_groups = ["${aws_security_group.T2_security_group.id}"]
  user_data       = "${data.template_file.slave.rendered}"
  tags = {
    Name = "${var.project}_mysql"
    role = "db"
  }
}

resource "aws_security_group" "T2_security_group" {
  name        = "allow_all"
  description = "Allow all traffic"
  vpc_id      = "${aws_vpc.T2_VPC.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.project}_sec_group"
  }
}
