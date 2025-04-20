provider "aws" {
  region = "us-east-1"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.8.4"

  cluster_name    = "cloud-onprem-eks"
  cluster_version = "1.29"
  subnet_ids      = var.private_subnets
  vpc_id          = var.vpc_id

  enable_irsa = true

  eks_managed_node_groups = {
    default = {
      desired_size = 2
      max_size     = 3
      min_size     = 1

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
    }
  }

  tags = {
    Environment = "prod"
    Project     = "cloud-onprem"
  }
}
