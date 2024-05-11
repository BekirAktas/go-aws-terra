terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = var.go_aws_terra_region
  profile = var.go_aws_terra_profile_name
}
