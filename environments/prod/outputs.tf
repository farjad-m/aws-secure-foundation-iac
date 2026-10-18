output "audit_bucket_arn" {
  value = module.audit_log_storage.bucket_arn
}

output "cloudtrail_arn" {
  value = module.account_audit_trail.cloudtrail_arn
}