module "cloudfront_app" {
  // https://registry.terraform.io/modules/terraform-aws-modules/cloudfront/aws/latest
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "3.2.1"

  create_distribution = true

  aliases = [var.app_domain]


  default_root_object = "index.html"
  comment             = "${local.pre-fix} CloudFront"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All" #
  retain_on_delete    = false
  wait_for_deployment = false

  # When you enable additional metrics for a distribution, CloudFront sends up to 8 metrics to CloudWatch in the US East (N. Virginia) Region.
  # This rate is charged only once per month, per metric (up to 8 metrics per distribution).
  #create_monitoring_subscription = true

  create_origin_access_identity = true
  origin_access_identities = {
    s3_app = "FE CloudFront can access"
  }

  logging_config = {
    bucket = var.s3_logs #module.log_bucket.s3_bucket_bucket_domain_name
    prefix = "cloudfront"

  origin = {
    s3_app = {
      domain_name = module.s3_app.s3_bucket_bucket_regional_domain_name
      s3_origin_config = {
        origin_access_identity = "s3_app" # key in `origin_access_identities`
        # cloudfront_access_identity_path = "origin-access-identity/cloudfront/E5IGQAA1QO48Z" # external OAI resource
      }
    }
    alb_api_redirects = {
      domain_name = "${var.api_domain}"
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "match-viewer"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = "s3_app"
    viewer_protocol_policy = "redirect-to-https" #"allow-all"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    query_string           = true

    #https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-response-headers-policies.html
    #response_headers_policy_id = "67f7725c-6f97-4210-82d7-5512b31e9d03" #SecurityHeadersPolicy
    response_headers_policy_id = "eaab4381-ed33-4a86-88ca-d9558dc6cd63" # CORS-with-preflight-and-SecurityHeadersPolicy

    # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html
    # "658327ea-f89d-4fab-a63d-7e88639e58f6" # Managed-CachingOptimized
    # "b2884449-e4de-46a7-ac36-70bc7f1ddd6d" # Managed-CachingOptimizedForUncompressedObjects
    # "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # Managed-CachingDisabled
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"

    # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-origin-request-policies.html
    # "acba4595-bd28-49b8-b9fe-13317c0390fa" # Managed-UserAgentRefererHeaders
    # "59781a5b-3903-41f3-afcb-af62929ccde1" # Managed-CORS-CustomOrigin
    # "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf" # Managed-CORS-S3Origin
    # "216adef6-5c7f-47e4-b989-5492eafa07d3" # Managed-AllViewer
    origin_request_policy_id = "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf"

    use_forwarded_values = false #? Required if "cache_policy_id" is used. See issue https://github.com/terraform-aws-modules/terraform-aws-cloudfront/pull/21

    #lambda_function_association = local.cf_basic_auth
    #dynamic "lambda_function_association" {
    #
    #  for_each = [] #var.cloudfront_enable_basic_auth == true ? [1] : []
    #
    #  content {
    #    viewer-request = {
    #        function_arn = "arn:aws:lambda:us-east-1:860299679056:function:basicAuth:1" #TODO make dinamic
    #    }
    #  }
    #}
  }

  ordered_cache_behavior = [
    {
      path_pattern           = "api/*"
      target_origin_id       = "alb_api_redirects"
      viewer_protocol_policy = "allow-all"

      allowed_methods = ["GET", "HEAD", "OPTIONS", "DELETE", "PATCH", "POST", "PUT", ]
      cached_methods  = ["GET", "HEAD"]
      compress        = true
      query_string    = true

      #https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-response-headers-policies.html
      # "67f7725c-6f97-4210-82d7-5512b31e9d03" #SecurityHeadersPolicy
      # "eaab4381-ed33-4a86-88ca-d9558dc6cd63" # CORS-with-preflight-and-SecurityHeadersPolicy
      response_headers_policy_id = "eaab4381-ed33-4a86-88ca-d9558dc6cd63"

      # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html
      # "658327ea-f89d-4fab-a63d-7e88639e58f6" # Managed-CachingOptimized
      # "b2884449-e4de-46a7-ac36-70bc7f1ddd6d" # Managed-CachingOptimizedForUncompressedObjects
      # "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # Managed-CachingDisabled
      cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"

      # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-origin-request-policies.html
      # "acba4595-bd28-49b8-b9fe-13317c0390fa" # Managed-UserAgentRefererHeaders
      # "59781a5b-3903-41f3-afcb-af62929ccde1" # Managed-CORS-CustomOrigin
      # "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf" # Managed-CORS-S3Origin
      # "216adef6-5c7f-47e4-b989-5492eafa07d3" # Managed-AllViewer
      origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"
      use_forwarded_values     = false #? Required if "cache_policy_id" is used. See issue https://github.com/terraform-aws-modules/terraform-aws-cloudfront/pull/21
    }
  ]

  custom_error_response = [
    {
      error_caching_min_ttl = 300
      error_code            = 404
      response_code         = 200
      response_page_path    = "/index.html"
    },
    {
      error_caching_min_ttl = 300
      error_code            = 403
      response_code         = 200
      response_page_path    = "/index.html"
    }
  ]
  viewer_certificate = {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }
}
}
