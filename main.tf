
module "eks" {
  source           = "./modules/eks"
  cluster_name     = var.cluster_name
  cluster_version  = var.cluster_version
  vpc_id           = var.vpc_id
  subnet_ids       = var.subnet_ids
  tags             = var.tags
  vpc_cni_version    = var.vpc_cni_version
  kube_proxy_version = var.kube_proxy_version
  coredns_version    = var.coredns_version
}

module "nodegroup" {
  source         = "./modules/nodegroup"
  cluster_name   = var.cluster_name
  subnet_ids     = var.subnet_ids
  tags           = var.tags
  node_role_arn  = var.node_role_arn
}
