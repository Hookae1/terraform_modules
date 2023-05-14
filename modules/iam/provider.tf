# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {     
  region = var.region_id
  default_tags {
    tags = {
      Terraform  = true
      Terragrunt = true
      Env        = var.env_id
      Project    = var.project_id
      Contact    = var.maintainer
    }
  }
}
