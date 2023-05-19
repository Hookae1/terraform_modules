# --- GitHub Actions Policies --- #

# Generate Policy Document to fetch data from AWS SSM
data "aws_iam_policy_document" "github_actions" {

  statement {
    sid    = "AllowBucketList"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = ["arn:aws:s3:::*"] #[for k in local.app_ids : module.s3_source["${k}"].s3_bucket_arn]
  }

  statement {
    sid    = "AllowBucketAccessforApp"
    effect = "Allow"
  
    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:DeleteObject"
    ]

    resources = [
      "arn:aws:s3:::bstk-stg-feadmin-webhosting/*",
      "arn:aws:s3:::bstk-stg-env-files/*",
      "arn:aws:s3:::bstk-prd-webhosting/*",
      "arn:aws:s3:::bstk-prd-env-files/*"
    ]  
  }

  statement {
    sid    = "iamAllowMultipartUpload"
    effect = "Allow"
  
    actions = [
      "s3:ListMultipartUploadParts",
      "s3:ListBucketMultipartUploads",
      "s3:AbortMultipartUpload"
    ]

    resources = [
      "arn:aws:s3:::bstk-stg-feadmin-webhosting/*",
      "arn:aws:s3:::bstk-stg-feadmin-webhosting",
      "arn:aws:s3:::bstk-prd-webhosting/*",
      "arn:aws:s3:::bstk-prd-webhosting"
    ]  
  }

  statement {
    sid    = "AllowInvalidateCloudFront"
    effect = "Allow"
  
    actions = [
      "cloudfront:CreateInvalidation",
      "cloudfront:GetDistribution"
    ]

    resources = ["*"]  
  }
}
#
module "iam_policy_github_actions" {
  // https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/latest
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~>5.0"

  create_policy = true

  name        = "${var.project_id}-GitHubActionsPolicy"
  description = "Allow GithubActions to call AWS Resources"
  path        = "/github/"

  policy = data.aws_iam_policy_document.github_actions.json

  tags = {
    Role = "GitHubActionsPolicy"
  }
}
