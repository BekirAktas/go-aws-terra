variable "go_aws_terra_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "go_aws_terra_vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "go_aws_terra_public_subnet_cidr_blocks" {
  description = "CIDR blocks for the public subnets"
  type        = string
  default     = "10.0.1.0/24" 
}

variable "go_aws_terra_private_subnet_cidr_blocks" {
  description = "CIDR blocks for the private subnets"
  type        = string
  default     = "10.0.10.0/24" 
}

variable "go_aws_terra_public_subnet_cidr_blocks_b" {
  description = "CIDR blocks for the public subnets_b"
  type        = string
  default     = "10.0.2.0/24" 
}

variable "go_aws_terra_private_subnet_cidr_blocks_b" {
  description = "CIDR blocks for the private subnets_b"
  type        = string
  default     = "10.0.11.0/24" 
}

variable "go_aws_terra_profile_name" {
  description = "iam programmatic"
  type        = string
  default     = "terraform-user" 
}

variable "db_username_1" {
  description = "database user name"
  type = string
}

variable "db_password_1" {
  description = "database password"
  type = string
  sensitive = true
}
