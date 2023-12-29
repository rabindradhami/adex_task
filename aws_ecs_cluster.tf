resource "aws_ecs_cluster" "django_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "django_task" {
  family                   = "django_task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]

  container_definitions = jsonencode([
    {
      name  = var.container_name
      image = var.docker_image
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        },
      ],
      log_configuration = {
        log_driver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/django"  
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    },
  ])
}
resource "aws_launch_configuration" "django_launch_config" {
  name = "django_launch_config"
  image_id = var.ami_image_id  
  instance_type = var.instance_type          
  security_groups = [aws_security_group.django_sg.id]  

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "django_autoscaling_group" {
  desired_capacity     = 1
  max_size             = 1
  min_size             = 1
  launch_configuration = aws_launch_configuration.django_launch_config.id
  vpc_zone_identifier  = [aws_subnet.public_subnet.id]
}

resource "aws_ecs_service" "django_service" {
  name            = "django_service"
  cluster         = aws_ecs_cluster.django_cluster.id
  task_definition = aws_ecs_task_definition.django_task.arn
  launch_type     = "EC2"
  desired_count   = 1

  network_configuration {
    subnets = [aws_subnet.public_subnet.id]
    security_groups = [aws_security_group.django_sg.id]
  }
}
