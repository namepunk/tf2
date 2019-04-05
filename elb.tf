resource "aws_elb" "T2_elb" {
  name               = "${var.project}appelb"
  subnets = ["${aws_subnet.T2_public.id}","${aws_subnet.T2_private1.id}","${aws_subnet.T2_private2.id}"]
#  availability_zones = ["${var.zone1}","${var.zone2}","${var.zone3}"]

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 80
    lb_protocol        = "http"
  }

  instances                   = ["${aws_instance.T2_app1.id}", "${aws_instance.T2_app2.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "${var.project}_app_elb"
  }
}
