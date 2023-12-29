variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  type    = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr_block" {
  type    = string
  default = "10.0.2.0/24"
}

variable "availability_zone" {
  default = "us-east-1a"
}

variable "django_from_port" {
  default = 0
}

variable "django_to_port" {
  default = 0
}

variable "django_protocol" {
  default = "-1"
}

variable "django_cidr_blocks" {
  default = ["0.0.0.0/0"]
}

variable "ecs_cluster_name" {
  type    = string
  default = "django-cluster"
}

variable "container_name" {
  type    = string
  default = "django"
}

variable "docker_image" {
  type    = string
  default = "docker-image-url"
}


variable "ami_image_id" {
  type    = string
  default = "ami-079db87dc4c10ac91"
}


variable "instance_type" {
  type    = string
  default = "t2.micro"
}


variable "repository_name" {
  type    = string
  default = "django_repository"
}

variable "s3_bucket_name" {
  type    = string
  default = "django_lb_bucket"
}

variable "lb_name" {
  type    = string
  default = "django_lb"
}

