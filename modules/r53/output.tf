output "acm_certificate_arn" {
    description = "TLS certificate Arn to use from ACM"
    value       = module.acm_global.acm_certificate_arn
}