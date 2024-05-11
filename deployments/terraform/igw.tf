resource "aws_internet_gateway" "go-aws-terra-internet-gateway" {
  vpc_id    = aws_vpc.go_aws_terra_main_vpc.id
  tags      = {
    Name    = "igw"
  }
}
