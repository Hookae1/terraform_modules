output "app_domain" {
    description = "Domain of FE application"
    value       = module.r53_records.records["www"][0]
}

output "api_domain" {
    description = "Domain of API application"
    value       = module.r53_records.records["api"][0]
}

output "acm_certificate_arn" {
    description = "TLS certificate Arn to use from ACM"
    value       = module.acm_global.acm_certificate_arn
}