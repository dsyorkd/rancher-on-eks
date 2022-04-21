variable "vpc_create" {
  type        = bool
  description = "Toggle to create a new VPC"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID of the pre-existing VPC."
  default     = ""
}

variable "vpc_name" {
  type        = string
  description = "Name for new VPC"
  default     = "rancher-eks"
}

variable "region" {
  type        = string
  description = "The AWS region."
}

variable "subnet_name_filters_for_cluster" {
  type        = list(string)
  description = "The filters to be used on the subnet names to select the subnets to use for the cluster."
  default     = ["private"]
}

variable "subnet_name_filters_for_nodes" {
  type        = list(string)
  description = "The filters to be used on the subnet names to select the subnets to use for the nodes."
  default     = ["public"]
}

variable "node_group_max_size" {
  type        = string
  description = "Max nodes for node group."
  default     = "1"
}

variable "node_group_min_size" {
  type        = string
  description = "Min nodes for node group."
  default     = "1"
}

variable "node_group_desired_capacity" {
  type        = string
  description = "Desired nodes for node group."
  default     = "1"
}

variable "node_group_instance_type" {
  type        = string
  description = "Node instance type."
  default     = "m5.large"
}

variable "base_domain" {
  type        = string
  description = "Base domain for the Rancher subdomain."
}

variable "base_domain_create" {
  type        = bool
  description = "Toggle to create route53 zone record for base domain"
}

variable "cluster_name" {
  type        = string
  description = "The EKS cluster name. Name is auto generated as 'rancher-rAnDomChARs' if empty"
  default     = ""
}

variable "shell_interpreter" {
  type        = list(string)
  description = "The shell interpreter that should be used for the EKS 'wait for cluster'."
  default     = ["bash", "-c"]
}

variable "kubernetes_version" {
  type        = string
  description = "The Kubernetes version to choose, must be available for EKS."
}

variable "ingress_nginx_version" {
  type        = string
  description = "Ingress Nginx version"
}

variable "ingress_nginx_values_filename" {
  type        = string
  description = "Filename for the Helm values YAML file for ingress-nginx"
  default     = ""
}

variable "cert_manager_version" {
  type        = string
  description = "Cert-manager version from https://cert-manager.io/docs/installation/kubernetes/"
}

variable "cert_manager_values_filename" {
  type        = string
  description = "Filename for the Helm values YAML file for cert-manager"
  default     = ""
}

variable "cert_manager_letsencrypt_environment" {
  type        = string
  description = "Lets Encrypt environment, valid options are 'staging' or 'production'"
}

variable "cert_manager_letsencrypt_email" {
  type        = string
  description = "Lets Encrypt environment, email address for notifications"
}

variable "rancher_version" {
  type        = string
  description = "Rancher version"
}

variable "rancher_values_filename" {
  type        = string
  description = "Filename for the Helm values YAML file for rancher"
  default     = ""
}

variable "rancher_admin_password" {
  type        = string
  description = "Rancher admin password"
}


variable "environment" {
  type        = string
  description = "environment rancher is running in E.g. dev, perf, prod"
}
