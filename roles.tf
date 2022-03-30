# get account ID

data "aws_caller_identity" "current" {}

locals {
  role_principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
}


resource "aws_iam_role" "k8s-admin-role" {
  name = "eks-k8s-admin-role-${var.project_name}"


  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          "AWS" : "${local.role_principal_arn}"
        }
      },
    ]
  })

  tags = {
    tag-key = "EKS-${var.project_name}"
  }
}


resource "aws_iam_role" "k8s-dev-role" {
  name = "eks-k8s-dev-role-${var.project_name}"


  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          "AWS" : "${local.role_principal_arn}"
        }
      },
    ]
  })

  tags = {
    tag-key = "EKS-${var.project_name}"
  }
}