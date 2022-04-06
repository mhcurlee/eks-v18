output "admin-role-arn" {
  value = aws_iam_role.k8s-admin-role.arn
}

output "dev-role-arn" {
  value = aws_iam_role.k8s-dev-role.arn
}

output "cluster-name" {
  value = var.project_name
}