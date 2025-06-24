
provider "kubernetes" {
  host                   = aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}

data "aws_eks_cluster_auth" "this" {
  name = aws_eks_cluster.this.name
}


data "aws_iam_role" "existing_cluster_role" {
  count = var.use_existing_cluster_role ? 1 : 0
  name  = var.existing_cluster_role_name
}

resource "aws_iam_role" "new_cluster_role" {
  count = var.use_existing_cluster_role ? 0 : 1
  name  = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

locals {
  cluster_role_arn = var.use_existing_cluster_role ? data.aws_iam_role.existing_cluster_role[0].arn : aws_iam_role.new_cluster_role[0].arn
}

resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = local.cluster_role_arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  tags = var.tags
}

resource "kubernetes_service_account" "irsa_sa" {
  metadata {
    name      = "irsa-sa"
    namespace = "default"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.irsa_example.arn
    }
  }
}
