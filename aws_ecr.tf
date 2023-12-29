resource "aws_ecr_repository" "django_repository" {
  name = var.repository_name
}

resource "aws_ecr_lifecycle_policy" "django_policy" {
  repository = aws_ecr_repository.django_repository

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 2 images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["v"],
                "countType": "imageCountMoreThan",
                "countNumber": 2
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}