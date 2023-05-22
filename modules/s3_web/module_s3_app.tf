data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "AllowGitHubToUpload"
    principals {
      type        = "AWS"
      identifiers = [
        "arn:aws:iam::692202383097:role/github/GitHubRole"
      ]
    }

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:DeleteObject",
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${local.s3_bucket_name}/*",
      "arn:aws:s3:::${local.s3_bucket_name}",
    ]
  }

  statement {
    sid       = "AllowCloudFront"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${local.s3_bucket_name}/*"]

    principals {
      type        = "AWS"
      identifiers = module.cloudfront_app.cloudfront_origin_access_identity_iam_arns
    }
  }

  statement {
    sid       = "CloudFrontAllowListBucket"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${local.s3_bucket_name}"]

    principals {
      type        = "AWS"
      identifiers = module.cloudfront_app.cloudfront_origin_access_identity_iam_arns
    }
  }

  statement {
    sid = "AllowPublicAccess" #Only for test porposes
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${local.s3_bucket_name}/*",
    ]
  }
}

module "s3_app" {
  # https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest
  source        = "terraform-aws-modules/s3-bucket/aws"
  version       = "3.10.1"
  create_bucket = true

  bucket = local.s3_bucket_name
  acl    = "private"

  # Bucket policies
  attach_policy = true
  policy        = data.aws_iam_policy_document.bucket_policy.json

  # Need to add this to avoid retrieve Error - The bucket does not allow ACLs status code: 400
  # https://github.com/terraform-aws-modules/terraform-aws-s3-bucket/issues/223
  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = false #true
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  # Website Settings
  website = {
    index_document = "index.html"
    error_document = "index.html"
  }

  # CORS
  cors_rule = [
    {
      allowed_methods = ["PUT", "POST", "GET", "HEAD"]
      allowed_origins = ["*"]
      allowed_headers = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    }
  ]

  tags = {
    App  = "webhosting"
    Role = "S3"
  }
}
