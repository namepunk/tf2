
data "aws_ami" "ami_ubuntu_18_04" {
  most_recent      = true
  name_regex       = "^ubuntu-bionic-18.04"
  owners = ["amazon"]
}

data "local_file" "cert_pub_data" {
    filename = "${path.module}/${var.cert_pub}"
}

data "local_file" "cert_priv_data" {
    filename = "${path.module}/${var.cert_priv}"
}

data "template_file" "slave" {
  template = "${file("${path.module}/slaves.tpl")}"
  vars = {
    cert = "${data.local_file.cert_pub_data.content}"
  }
}

data "template_file" "bastion" {
  template = "${file("${path.module}/bastion.tpl")}"
  vars = {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    priv = "${data.local_file.cert_priv_data.content}" 
  }

}

