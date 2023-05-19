output "s3_logs" {
    description = "S3 bucket for storing logs"
    value       = module.s3_logs.s3_bucket_bucket_domain_name
}