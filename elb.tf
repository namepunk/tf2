resource "aws_elb" "T2_elb" {
	name			= "T2_elb"
	availability_zones	= ["${var.zone1}", "${var.zone2}"]
	security_groups    = ["${aws_security_group.T2_security_group.id}"]
	listener {
		instance_port		= 80
		instance_protocol	= "http"
		lb_port			= 80
		lb_protocol		= "http"
	}	


	health_check {
		healthy_threshold	= 2
		unhealthy_threshold     = 2
		timeout			= 3
		target			= "HTTP:80/"
		interval		= 30

}
}
