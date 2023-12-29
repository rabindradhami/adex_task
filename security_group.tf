resource "aws_security_group" "django_sg" {
  name        = "django_sg"
  description = "Security group for django_sg"

  ingress {
    from_port   = var.django_from_port
    to_port     = var.django_to_port
    protocol    = var.django_protocol
    cidr_blocks = var.django_cidr_blocks
  }
}

