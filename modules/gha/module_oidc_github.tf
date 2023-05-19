module "aws_oidc_github" {
  // https://registry.terraform.io/modules/unfunco/oidc-github/aws/latest
  source  = "unfunco/oidc-github/aws"
  version = "0.8.0"

  enabled = true

  attach_read_only_policy = true # For test porporces

  iam_role_path = "/github/"
  iam_role_name = "GitHubRole"
  iam_role_policy_arns = [
    module.iam_policy_github_actions.arn
  ]

  github_repositories = [
    null
  ]

  tags = {
    Role = "GitHub Connection"
  }
}