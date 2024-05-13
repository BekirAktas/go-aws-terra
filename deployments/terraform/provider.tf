terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
        version = "~> 5.0"
    }
    helm = {
      source  = "hashicorp/helm"
    }
  }
}
provider "aws" {
  region = var.go_aws_terra_region
  profile = var.go_aws_terra_profile_name
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster-auth.token
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

