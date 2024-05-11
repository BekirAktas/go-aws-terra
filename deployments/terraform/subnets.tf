resource "aws_subnet" "go_aws_terra_public_subnet" {
  cidr_block        = var.go_aws_terra_public_subnet_cidr_blocks
  vpc_id            = aws_vpc.go_aws_terra_main_vpc.id
  availability_zone = "us-east-1a"
  tags = {
    Name = "Public subnet"
  }
}

resource "aws_subnet" "go_aws_terra_private_subnet" {
  cidr_block        = var.go_aws_terra_private_subnet_cidr_blocks
  vpc_id            = aws_vpc.go_aws_terra_main_vpc.id
  availability_zone = "us-east-1a"
  tags = {
    Name = "Private subnet"
  }
}

resource "aws_subnet" "go_aws_terra_public_subnet_b" {
  cidr_block        = var.go_aws_terra_public_subnet_cidr_blocks_b
  vpc_id            = aws_vpc.go_aws_terra_main_vpc.id
  availability_zone = "us-east-1b"
  tags = {
    Name = "Public subnet"
  }
}

resource "aws_subnet" "go_aws_terra_private_subnet_b" {
  cidr_block        = var.go_aws_terra_private_subnet_cidr_blocks_b
  vpc_id            = aws_vpc.go_aws_terra_main_vpc.id
  availability_zone = "us-east-1b"
  tags = {
    Name = "Private subnet"
  }
}
