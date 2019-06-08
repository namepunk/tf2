resource "aws_instance" "T2_bastion" {
  ami =  "${data.aws_ami.ami_ubuntu_18_04.id}"
  instance_type = "t2.micro"
  key_name = "${var.user_key}"
  subnet_id = "${aws_subnet.T2_public.id}"
  security_groups = ["${aws_security_group.T2_security_group.id}"]
  user_data       = "${data.template_file.bastion.rendered}"
  tags = {
    Name = "${var.project}_bastion"
  depends_on = "aws_instance.T2_mysql"
  depends_on = "aws_instance.T2_app1"
  depends_on = "aws_instance.T2_app2"
  }
}

resource "aws_launch_configuration" "T2_launch_cfg" {
  name                   = "T2_launch_cfg"
  image_id               = "${data.aws_ami.ami_ubuntu_18_04.id}"
  instance_type          = "t2.micro"
  security_groups        = ["${aws_security_group.T2_security_group.id}"]
  key_name               = "${var.user_key}"
  user_data = "${data.template_file.slave.rendered}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "T2_asg" {
  name = "T2_asg"
  launch_configuration = "${aws_launch_configuration.T2_launch_cfg.id}"
  min_size = 2
  max_size = 2
##  depends_on = ["${aws_lb.T2_elb.name}"]
  force_delete = true
  health_check_type = "EC2"
  health_check_grace_period = 600
  target_group_arns         = ["${aws_lb_target_group.T2_lb_target_group.arn}"]
  vpc_zone_identifier = ["${aws_subnet.T2_private1.id}", "${aws_subnet.T2_private2.id}"]
  tag {
    key = "role"
    value = "app"
    propagate_at_launch = true
  }
    tag {
    key = "Name"
    value = "app"
    propagate_at_launch = true
  }
}




resource "aws_instance" "T2_mysql" {
  ami = "${data.aws_ami.ami_ubuntu_18_04.id}"
  instance_type = "t2.micro"
  key_name = "${var.user_key}"
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
