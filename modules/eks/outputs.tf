
output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_role_arn" {
  value = local.cluster_role_arn
}
