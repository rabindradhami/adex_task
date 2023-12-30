#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root"
  exit 1
fi

sudo apt install docker -y

sudo apt install awscli -y

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose


echo "Creating AWS ECR Repository for Django App"

cd aws_ecr

terraform init

terraform plan

terraform apply -auto-approve

echo "Repo Creating Success"


cd ..

echo "Building Docker Image and pushing it to ECR"

cd django-docker-quickstart

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin xxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com

DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose -f docker-compose.yml up --build -d

docker images

docker tag django-docker-quickstart_backend:latest xxxxxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/django-repository:latest

docker push xxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/django-docker-quickstart_backend:latest

cd ..


echo "Creating AWS Services (ECS,LB, RDS)"


cd aws_remaining

terraform init

terraform plan

terraform apply -auto-approve