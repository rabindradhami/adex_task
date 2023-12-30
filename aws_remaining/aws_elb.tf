resource "aws_lb" "django_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.django_sg.id]
  subnets            = [aws_subnet.public_subnet.id]

  enable_deletion_protection = true
}


resource "aws_lb_listener" "django_lb_listener" {
  load_balancer_arn = aws_lb.django_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.django_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.django_lb_target_group.arn
  }
}

resource "aws_lb_target_group" "django_lb_target_group" {
  name     = var.django_lb_target_group_name
  port     = 443
  protocol = "HTTPS"
  vpc_id   = aws_vpc.django_vpc.id
}
