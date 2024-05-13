module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  cluster_version = "1.29"
  vpc_id = aws_vpc.go_aws_terra_main_vpc.id
  subnet_ids = [aws_subnet.go_aws_terra_private_subnet.id, aws_subnet.go_aws_terra_private_subnet_b.id]
  cluster_name ="go-aws-terra-cluster"
  tags = {
    Name: "go-aws-terra-cluster"
  }
  node_security_group_name = "t3a-small-bottlerocket"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }
  enable_cluster_creator_admin_permissions = true
  eks_managed_node_groups = {
    go-aws-terra = {
      ami_type               = "BOTTLEROCKET_x86_64"
        platform               = "bottlerocket"
        instance_types         = ["t3a.small"]
        capacity_type          = "ON_DEMAND"
        min_size               = 1
        max_size               = 1
        desired_size           = 1
    }
  }
}

 module "eks_auth" {
   source  = "terraform-aws-modules/eks/aws//modules/aws-auth"
   version = "~> 20.0"
   manage_aws_auth_configmap = true
   aws_auth_roles = [
     {
       rolearn  = aws_iam_role.node-group-role.arn
       username = "node-roles"
       groups   = ["system:masters"]
     },
   ]
   aws_auth_users = [
     {
       userarn  = "arn:aws:iam::686439568832:user/terraform-user"
       username = "terraform-user"
       groups   = ["system:masters"]
     },
     {
       userarn  = "arn:aws:iam::686439568832:root"
       username = "root"
       groups   = ["system:masters"]
     },
   ]
 }

data "aws_eks_cluster_auth" "cluster-auth" {
  name = module.eks.cluster_name
}
