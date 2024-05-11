resource "aws_route_table" "go-aws-terra-public-route-table" {
  vpc_id    = aws_vpc.go_aws_terra_main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.go-aws-terra-internet-gateway.id
  }

  tags       = {
    Name     = "Public Route Table"
  }
}

resource "aws_route_table" "go-aws-terra-private-route-table" {
  vpc_id    = aws_vpc.go_aws_terra_main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.go-aws-terra-nat-gateway.id
  }

  tags       = {
    Name     = "Private Route Table"
  }
}

resource "aws_route_table_association" "private-subnet-route-table-association" {
  subnet_id           = aws_subnet.go_aws_terra_private_subnet.id
  route_table_id      = aws_route_table.go-aws-terra-private-route-table.id
}

resource "aws_route_table_association" "public-subnet-route-table-association" {
  subnet_id           = aws_subnet.go_aws_terra_public_subnet.id
  route_table_id      = aws_route_table.go-aws-terra-public-route-table.id
}

resource "aws_route_table_association" "private-subnet-route-table-association-b" {
  subnet_id           = aws_subnet.go_aws_terra_private_subnet_b.id
  route_table_id      = aws_route_table.go-aws-terra-private-route-table.id
}

resource "aws_route_table_association" "public-subnet-route-table-association-b" {
  subnet_id           = aws_subnet.go_aws_terra_public_subnet_b.id
  route_table_id      = aws_route_table.go-aws-terra-public-route-table.id
}
