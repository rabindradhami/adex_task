terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
    region = var.region
    access_key = "access_key_id"
    secret_key = "secret_key"
  default_tags {
    tags = {
      Author = "Rabindra Dhami"
      ENV = "dev"
      Project = "DjangoApp"
      Date = "29 Dec 2023"
      terraform = "true"
    }
  }
}
