module "vpc" {
  # https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  create_vpc = true

  name = "${local.pre-fix}-vpc"
  cidr = "10.0.0.0/16"

  azs                 = ["${var.region_id}a", "${var.region_id}b"] # setup for 2AZ
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24"]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  database_subnets    = ["10.0.21.0/24", "10.0.22.0/24"]
  elasticache_subnets = ["10.0.31.0/24", "10.0.32.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true

}