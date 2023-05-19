output "cloudfront_domain_name" {
  value = module.cloudfront_app.cloudfront_distribution_domain_name
}

output "cloudfront_zone_id" {
  value = module.cloudfront_app.cloudfront_distribution_hosted_zone_id
}
