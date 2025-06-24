
variable "cluster_name" {}
variable "cluster_version" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "tags" {
  type = map(string)
}
variable "vpc_cni_version" {}
variable "kube_proxy_version" {}
variable "coredns_version" {}
variable "node_role_arn" {}
