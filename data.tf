
data "aws_ami" "ami_ubuntu_18_04" {
  most_recent      = true
  name_regex       = "^ubuntu-bionic-18.04"
  owners = ["amazon"]
}

data "template_file" "slave" {
  template = "${file("${path.module}/slave.tpl")}"
}
data "template_file" "bastion" {
  template = "${file("${path.module}/bastion.tpl")}"
}

