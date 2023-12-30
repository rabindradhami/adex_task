resource "aws_acm_certificate" "django_cert" {
  domain_name       = "rabindradhami.com.np"
  validation_method = "EMAIL"
}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn = aws_acm_certificate.django_cert.arn
}