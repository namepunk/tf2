
data "aws_ami" "ami_ubuntu_18_04" {
  most_recent      = true
  name_regex       = "^ubuntu-bionic-18.04"
  owners = ["amazon"]
}

