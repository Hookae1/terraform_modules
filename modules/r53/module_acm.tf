module "acm" {
  // https://registry.terraform.io/modules/terraform-aws-modules/acm/aws/latest
  source  = "terraform-aws-modules/acm/aws"
  version = "4.3.2"

  create_certificate = true

  domain_name = var.domain
  zone_id     = module.r53_zones.route53_zone_zone_id[var.domain]

  subject_alternative_names = [
    "*.${var.domain}",
    var.domain,
  ]

  wait_for_validation = false

  tags = {
    Role = "Cert"
  }
  depends_on = [module.r53_zones]
}


module "acm_global" {
  // https://registry.terraform.io/modules/terraform-aws-modules/acm/aws/latest
  source  = "terraform-aws-modules/acm/aws"
  version = "4.3.2"

  providers = {
    aws = aws.global
  }

  create_certificate = true

  domain_name = var.domain
  zone_id     = module.r53_zones.route53_zone_zone_id[var.domain]

  subject_alternative_names = [
    "*.${var.domain}",
    var.domain,
  ]

  wait_for_validation = false

  tags = {
    Role = "Cert"
  }
  depends_on = [module.r53_zones]
}
