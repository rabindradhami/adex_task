resource "aws_lb" "django_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.django_sg.id]
  subnets            = [aws_subnet.public_subnet.id]

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "django-lb"
    enabled = true
  }
}