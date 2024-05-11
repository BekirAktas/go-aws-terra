#resource "aws_db_instance" "go_aws_terra_main_db_instance" {
#  engine                = "mongodb"
#  engine_version        = "4.0.10" 
#  multi_az              = false
#  identifier            = "go-aws-terra-rds-mongodb"
#  username              = "go-aws-terra"
#  password              = "b912cccb41e841b5"
#  instance_class        = "db.t2.micro"
#  allocated_storage     = 20
#  storage_type          = "gp2"
#  parameter_group_name  = "default.mongodb4.0"
#  db_name               = "go-aws-terra"
#  availability_zone     = var.go_aws_terra_region
#}
