data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name" 
    values = ["${local.pre-fix}-vpc"]
  }
}

data "aws_subnets" "selected-private" {
  filter {
    name   = "tag:Name"
    values = ["${local.pre-fix}-vpc-private-${var.region_id}*"]
  }
}

data "aws_subnets" "selected-public" {
  filter {
    name   = "tag:Name"
    values = ["${local.pre-fix}-vpc-public-${var.region_id}*"]
  }
}

data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}