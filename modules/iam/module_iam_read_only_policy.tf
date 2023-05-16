module "iam_read_only_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-read-only-policy"
  version = "~> 5"

  name        = "${var.project_id}-ReadOnlyPolicy"
  path        = "/${var.project_id}/groups/readonly/"
  description = "My read-only policy for Devs"

  allowed_services = ["rds", "ec2", "s3"]
}
