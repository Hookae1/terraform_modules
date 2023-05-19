module "r53_zones" {
  // https://registry.terraform.io/modules/terraform-aws-modules/route53/aws/latest

  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2.0"

  zones = {
    "${var.domain}" = {
      comment = "${var.domain}"
    }
  }

  tags = {
    Role = "Dns"
  }
}

module "r53_records" {
  // https://registry.terraform.io/modules/terraform-aws-modules/route53/aws/latest
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = keys(module.r53_zones.route53_zone_zone_id)[0]

  records = [
    {
      name    = "www"
      type    = "A"
      ttl     = 300
      records = [var.public_ip]
    },
    {
      name    = "api"
      type    = "A"
      ttl     = 300
      records = [var.public_ip]
    },
    {
      name    = "portainer"
      type    = "A"
      ttl     = 300
      records = [var.public_ip]
    }
  ]

  depends_on = [module.r53_zones]
}
