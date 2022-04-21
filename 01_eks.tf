data "aws_vpc" "vpc" {
  count = var.vpc_create == 0 ? 1 : 0
  id = var.vpc_create == 0 ? module.vpc.vpc_id : var.vpc_id
}

data "aws_availability_zones" "available" {
}

data "aws_subnets" "cluster_subnet_set" {
  count = length(var.subnet_name_filters_for_cluster)
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = [var.subnet_name_filters_for_cluster[count.index]]
  }
}

data "aws_subnets" "node_subnet_set" {
  count = length(var.subnet_name_filters_for_nodes)
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = [var.subnet_name_filters_for_nodes[count.index]]
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

resource "aws_kms_key" "eks" {
  description = "${local.cluster_name}-eks-secrets-key"
}

module "eks" {
  source          = "github.com/terraform-aws-modules/terraform-aws-eks"
  cluster_name    = local.cluster_name
  cluster_version = var.kubernetes_version
  vpc_id          = data.aws_vpc.vpc.id

  subnet_ids = var.vpc_create && (length(flatten(module.vpc.*.private_subnets)) == 0) ? module.vpc.private_subnets : flatten([for subnets in data.aws_subnets.cluster_subnet_set : tolist(subnets.ids)])

  cluster_encryption_config = [
    {
      provider_key_arn = aws_kms_key.eks.arn
      resources        = ["secrets"]
    }
  ]

  eks_managed_node_group_defaults = {
    subnets              = flatten([for subnets in data.aws_subnets.node_subnet_set : tolist(subnets.ids)])
    asg_max_size         = var.node_group_max_size
    asg_min_size         = var.node_group_min_size
    asg_desired_capacity = var.node_group_desired_capacity
    instance_type        = var.node_group_instance_type
  }

  eks_managed_node_groups = {
    main = {
      key_name = ""
    }
  }

  tags = {
    Environment = "prod"
  }
}
