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
  acl    = "log-delivery-write"
  policy = data.aws_iam_policy_document.s3_logs.json

  # Need to add this to avoid retrieve Error - The bucket does not allow ACLs status code: 400
  # https://github.com/terraform-aws-modules/terraform-aws-s3-bucket/issues/223
  control_object_ownership = true
  object_ownership         = "ObjectWriter"

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
