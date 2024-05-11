resource "aws_vpc" "go_aws_terra_main_vpc" {
  cidr_block = var.go_aws_terra_vpc_cidr_block
  tags = {
    Name = "go_aws_terra_main_vpc"
  }
}
