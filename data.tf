
data "aws_ami" "ami_ubuntu_18_04" {
  most_recent      = true
  name_regex       = "^ubuntu-bionic-18.04"
  owners = ["amazon"]
}

data "template_file" "slave" {
  template = "${file("${path.module}/slaves.tpl")}"
  vars {
    cert = "${var.cert_pub}"
  }
}

data "template_file" "bastion" {
  template = "${file("${path.module}/bastion.tpl")}"
  vars {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    priv = "${var.cert_priv}"
  }

}

