resource "aws_db_instance" "go_aws_terra_main_db_instance" {
  identifier            = "go-aws-terra-rds-postgres"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "16"
  skip_final_snapshot    = true
  publicly_accessible    = true
  db_subnet_group_name = aws_db_subnet_group.go-aws-terra-db-subnet-groups.name
  vpc_security_group_ids = [aws_security_group.database-security-group.id]
  username               = aws_secretsmanager_secret_version.db_username_version.secret_string
  password               = aws_secretsmanager_secret_version.db_password_version.secret_string
}
