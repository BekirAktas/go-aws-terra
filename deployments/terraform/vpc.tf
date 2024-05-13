resource "aws_vpc" "go_aws_terra_main_vpc" {
  cidr_block = var.go_aws_terra_vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "go_aws_terra_main_vpc"
  }
}
