resource "aws_security_group" "go-aws-terra-alb-security-group" {
  name        = "ALB Security Group"
  description = "Enable HTTP/HTTPS access on Port 80/443"
  vpc_id      = aws_vpc.go_aws_terra_main_vpc.id

  ingress {
    description      = "HTTP Access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTPS Access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "ALB Security Group"
  }
}

resource "aws_security_group" "server-security-group" {
  name        = "Server Security Group"
  description = "Enable HTTP/HTTPS access on Port 80/443 via ALB and SSH access on Port 22 via SSH SG"
  vpc_id      = aws_vpc.go_aws_terra_main_vpc.id

  ingress {
    description      = "HTTP Access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = ["${aws_security_group.go-aws-terra-alb-security-group.id}"]
  }

  ingress {
    description      = "HTTPS Access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    security_groups  = ["${aws_security_group.go-aws-terra-alb-security-group.id}"]
  }

  ingress {
    description      = "SSH Access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = ["${aws_security_group.go-aws-terra-alb-security-group.id}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "Web Server Security Group"
  }
}

resource "aws_security_group" "database-security-group" {
  name        = "Database Security Group"
  description = "Enable mongodb access on Port 27017"
  vpc_id      = aws_vpc.go_aws_terra_main_vpc.id

  ingress {
    description      = "mongo db"
    from_port        = 27017
    to_port          = 27017
    protocol         = "tcp"
    security_groups  = ["${aws_security_group.server-security-group.id}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "Database Security Group"
  }
}

resource "aws_db_subnet_group" "go-aws-terra-db-subnet-groups" {
  name       = "main"
  subnet_ids = [aws_subnet.go_aws_terra_private_subnet.id, aws_subnet.go_aws_terra_private_subnet_b.id]

  tags = {
    Name = "DB subnet groups"
  }
}
