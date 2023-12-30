resource "aws_db_instance" "postgres" {
  identifier           = "django-db-instance"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "15.4-R3"
  instance_class       = "db.t2.micro"
  username             = "database"
  password             = "database@123"
  
  vpc_security_group_ids = [aws_security_group.django_sg.id]
  
  parameter_group_name = "default.postgres12"
  
  skip_final_snapshot = true
}
