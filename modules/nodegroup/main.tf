
data "aws_iam_role" "existing" {
  count = var.use_existing_node_role ? 1 : 0
  name  = var.existing_node_role_name
}

resource "aws_iam_role" "new" {
  count = var.use_existing_node_role ? 0 : 1
  name  = "eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

locals {
  node_role_arn = var.use_existing_node_role ? data.aws_iam_role.existing[0].arn : aws_iam_role.new[0].arn
}

resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-ng"
  node_role_arn   = local.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  tags = var.tags
}
