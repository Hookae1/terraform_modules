/*
module "iam_group_ro" {
  # https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/latest
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "5.18.0"

  name = "DEV-READ-ONLY-ACCESS" #-${local.project_id_to_upper}"

  group_users = var.readonly_team

  attach_iam_self_management_policy = true

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess",
    module.iam_read_only_policy.arn
  ]
}

module "iam_group_dev_minimal" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "5.18.0"

  name = "DEV-MINIMAL-ACCESS" # -${local.project_id_to_upper}"

  group_users = var.dev_minimal_team

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
    "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess",
    "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess",
    "arn:aws:iam::aws:policy/AmazonECS_FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    module.iam_read_only_policy.arn
  ]
}

module "iam_group_dev" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "5.18.0"

  name = "DEV-POWER-ACCESS" # -${local.project_id_to_upper}"

  group_users = var.dev_power_team

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/PowerUserAccess", # TODO Change to more restrictive
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
    "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess",
    "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess",
    "arn:aws:iam::aws:policy/AmazonECS_FullAccess",
  ]
}
*/

module "iam_group_admin" {
  # https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/latest
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "5.18.0"

  name = "ADMIN-ACCESS" #${local.project_id_to_upper}"

  group_users = var.admin_team

  attach_iam_self_management_policy = true

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]
}
