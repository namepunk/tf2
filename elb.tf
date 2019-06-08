resource "aws_lb" "T2_elb" {
  name               = "${var.project}appelb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.T2_security_group.id}"]
  subnets = ["${aws_subnet.T2_public.id}","${aws_subnet.T2_public2.id}"]
  tags = {
    Name = "${var.project}_app_elb"
  }
}

resource "aws_lb_listener" "T2_lb_listener" {  
  load_balancer_arn = "${aws_lb.T2_elb.arn}"  
  port              = "80"  
  protocol          = "HTTP"
  
  default_action {    
    target_group_arn = "${aws_lb_target_group.T2_lb_target_group.arn}"
    type             = "forward"  
  }
}

resource "aws_lb_target_group" "T2_lb_target_group" {  
  name     = "T2target"  
  port     = "80"  
  protocol = "HTTP"  
  vpc_id   = "${aws_vpc.T2_VPC.id}"   
  tags = {    
    name = "T2_tg"    
  }   
}

