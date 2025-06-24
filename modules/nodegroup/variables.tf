
variable "cluster_name" {}
variable "subnet_ids" {
  type = list(string)
}
variable "tags" {
  type = map(string)
}

variable "use_existing_node_role" {
  type    = bool
  default = true
}

variable "existing_node_role_name" {
  type    = string
  default = "eks-node-role"
}
