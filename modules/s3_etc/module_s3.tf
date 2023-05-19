# --- Policy for S3_API bucket --- #
data "aws_iam_policy_document" "s3_logs" {
  statement {
    sid    = "AllowBucketAccessforApp"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::${local.s3_logs}/*",
      "arn:aws:s3:::${local.s3_logs}"
    ]
  }
}

# --- Buckets for storing data generated from BE-API (tickets) --- #
module "s3_logs" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.10.1"

  bucket = "${local.s3_logs}"
  acl    = "public-read"
  policy = data.aws_iam_policy_document.s3_logs.json

  versioning = {
    enabled = false
  }

  lifecycle_rule = [

    {
      id                                     = "expire old versions"
      enabled                                = true
      abort_incomplete_multipart_upload_days = 7
      noncurrent_version_expiration = {
        days = 300
      }
    }
  ]
}
