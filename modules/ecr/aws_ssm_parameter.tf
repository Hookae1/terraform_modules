# Register important data in SSM Parameter Store
resource "aws_ssm_parameter" "ecr_repository_arn" {
  for_each = toset(local.app_ids)
  name     = "/common/${each.key}/ecr_repository_arn"
  type     = "String"
  value    = module.ecr["${each.key}"].repository_arn
}
resource "aws_ssm_parameter" "ecr_repository_arn_global" {
  for_each = toset(local.app_ids)
  provider = aws.global
  name     = "/common/${each.key}/ecr_repository_arn"
  type     = "String"
  value    = module.ecr["${each.key}"].repository_arn
}
resource "aws_ssm_parameter" "ecr_repository_url" {
  for_each = toset(local.app_ids)
  name     = "/common/${each.key}/erc_repository_url"
  type     = "String"
  value    = module.ecr["${each.key}"].repository_url
}
resource "aws_ssm_parameter" "ecr_repository_url_global" {
  for_each = toset(local.app_ids)
  provider = aws.global
  name     = "/common/${each.key}/erc_repository_url"
  type     = "String"
  value    = module.ecr["${each.key}"].repository_url
}
