resource "random_string" "suffix" {
  count   = var.cluster_name == "" ? 1 : 0
  length  = 8
  special = false
  lower   = true
  upper   = false
}

locals {
  cluster_name = var.cluster_name == "" ? "rancher-${random_string.suffix[0].result}" : var.cluster_name
  name         = local.cluster_name
  subdomain    = local.cluster_name
  full_domain  = "${local.subdomain}.${var.base_domain}"

  kubeconfig = <<KUBECONFIG


apiVersion: v1
clusters:
- cluster:
    server: ${module.eks.cluster_endpoint}
    certificate-authority-data: ${module.eks.cluster_certificate_authority_data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${local.cluster_name}"
KUBECONFIG
}

