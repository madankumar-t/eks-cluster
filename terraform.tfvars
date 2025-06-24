
cluster_name       = "secure-eks"
cluster_version    = "1.32"
vpc_id             = "vpc-xxxxxxxxxxxxxxxxx"
subnet_ids         = ["subnet-xxxxxxxx", "subnet-yyyyyyyy", "subnet-zzzzzzzz"]

tags = {
  Environment = "prod"
  Terraform   = "true"
}

vpc_cni_version    = "v1.18.1-eksbuild.1"
kube_proxy_version = "v1.32.0-eksbuild.1"
coredns_version    = "v1.11.1-eksbuild.6"
node_role_arn      = "arn:aws:iam::123456789012:role/eks-node-role"
