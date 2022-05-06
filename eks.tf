data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id

}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id

}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.20.2"


  cluster_name              = var.project_name
  cluster_version           = var.cluster_version
  subnet_ids                = module.vpc.private_subnets
  vpc_id                    = module.vpc.vpc_id
  cluster_enabled_log_types = var.cluster_enabled_log_types



  cluster_encryption_config = [
    {
      provider_key_arn = aws_kms_key.eks.arn
      resources        = ["secrets"]
    }
  ]

  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = aws_iam_role.k8s-admin-role.arn
      username = "admin-user"
      groups   = ["system:masters"]
    },
    {
      rolearn  = aws_iam_role.k8s-dev-role.arn
      username = "dev-user"
      groups   = [""]
    }
  ]


  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    disk_size      = 50
    instance_types = ["t3.small"]
    #vpc_security_group_ids = [aws_security_group.additional.id]
  }

  eks_managed_node_groups = {

    ng1 = {
      min_size     = 2
      max_size     = 10
      desired_size = 2
      ami_type = "BOTTLEROCKET_x86_64"

      instance_types = ["t3.small"]

      labels = {
      }

      tags = {
        ExtraTag = "example"
      }
    }
  }

}





