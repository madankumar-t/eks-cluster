
variable "cluster_name" {}
variable "cluster_version" {}
variable "subnet_ids" {
  type = list(string)
}
variable "tags" {
  type = map(string)
}

variable "vpc_cni_version" {}
variable "kube_proxy_version" {}
variable "coredns_version" {}

variable "use_existing_cluster_role" {
  type    = bool
  default = true
}

variable "existing_cluster_role_name" {
  type    = string
  default = "eks-cluster-role"
}
