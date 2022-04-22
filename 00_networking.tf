module "vpc" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v3.14.0"

  count = var.vpc_create != 0 ? 1 : 0

  name = var.vpc_name
  cidr = "10.0.0.0/16"

  azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2.6.0"

  count = var.base_domain_create ? 1 : 0

  zones = {
    (var.base_domain) = {
      comment = var.base_domain
      tags = {
        terraform = true
        env       = var.environment
      }
    }
  }

  tags = {
    Terraform = "true"
  }
}
