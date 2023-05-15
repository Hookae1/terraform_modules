data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}

#### ---- Data from VPC module ---- ####
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name" 
    values = ["${local.pre-fix}-vpc"]
  }
}

data "aws_subnets" "selected_private" {
  filter {
    name   = "tag:Name"
    values = ["${local.pre-fix}-vpc-private-${var.region_id}*"]
  }
}

data "aws_subnet" "selected_public" {
  filter {
    name   = "tag:Name"
    values = ["${local.pre-fix}-vpc-public-${var.region_id}-2a"]
  }
}

#### ---- Data from SG module ---- ####
data "aws_security_group" "ssh" {
  vpc_id = data.aws_vpc.selected.id
  name   = "ssh-${var.env_id}*"
}

data "aws_security_group" "web" {
  vpc_id = data.aws_vpc.selected.id
  name   = "web-${var.env_id}*"
}

data "aws_security_group" "data" {
  vpc_id = data.aws_vpc.selected.id
  name   = "db-${var.env_id}*"
}

#### ---- Data from IAM module ---- ####
data "aws_iam_instance_profile" "iam_profile" {
  name = "${local.pre-fix}-EC2InstanceProfile"
}