resource "aws_security_group" "dv10-sg-wp-base-alb" {
  name        = "dv10-sg-wp-base-alb"
  description = "Security Group for Application Load Balancer"
  vpc_id      = "${var.vpc_id}"

  ingress {
    description     = "HTTP from internet"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dv10-sg-wp-base-alb"
    Environment = "Development"
    Project = "Wordpress Base"
    IaC = "Terraform"
  }
}

resource "aws_lb" "dv10-alb-wp-base" { // WP Empleo Public ALB
  name               = "dv10-alb-wp-base"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.dv10-sg-wp-base-alb.id}"]
  subnets            = "${var.public_subnets}"

  tags = {
    Name = "dv10-alb-wp-base"
    Environment = "Development"
    Project = "Wordpress Base"
    IaC = "Terraform"
  }
}

resource "aws_lb_target_group" "dv10-tg-wp-base" { //WP Empleo Target Group
  name        = "dv10-tg-wp-base"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "${var.vpc_id}"

  health_check {
    interval            = "15"
    path                = "/health-check.php"
    healthy_threshold   = "2"
    unhealthy_threshold = "2"
    timeout             = "10"
    protocol            = "HTTP"
  }

  stickiness {
    type            = "lb_cookie"
    cookie_duration = "86400"
    enabled         = "true"
  }

  tags = {
    Name = "dv10-tg-wp-base"
    Environment = "Development"
    Project = "Wordpress Base"
    IaC = "Terraform"
  }

}