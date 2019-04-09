variable project {
        default = "T2"
}

variable VPC_CIDR {
	default = "10.0.0.0/16" 
}

variable subnet_pub {
        default = "10.0.1.0/24"
}
variable subnet_pub2 {
        default = "10.0.4.0/24"
}
variable subnet_pr1 {
        default = "10.0.2.0/24"
}
variable subnet_pr2 {
        default = "10.0.3.0/24"
}

variable zone1 {
        default = "eu-central-1a"
}
variable zone2 {
        default = "eu-central-1b"
}
variable zone3 {
        default = "eu-central-1c"
}

variable "cert_pub" {
      default = "cert"
}

variable access_key {
        default = "key"
}
variable secret_key {
        default = "secret"
}

variable cert_priv {
      default = "cert"
}
variable user_key {
      default = "mykey"
}
