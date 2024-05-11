resource "aws_eip" "eip-nat-gateway" {
  tags   = {
    Name = "EIP"
  }
}
