resource "aws_nat_gateway" "go-aws-terra-nat-gateway" {
  allocation_id = aws_eip.eip-nat-gateway.id
  subnet_id     = aws_subnet.go_aws_terra_private_subnet.id

  tags   = {
    Name = "Nat Gateway Private Subnet"
  }
}

