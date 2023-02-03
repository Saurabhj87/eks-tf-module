variable "subnet_private_ids" {
  type = list(string)
}
variable "eks_iam_role_name" {
  type = string
  default = "eks-role-for-test"
}
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "eks_cluster_name" {
  type = string
}
