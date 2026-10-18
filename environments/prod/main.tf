module "audit_log_storage" {
  source                   = "../../modules/secure-s3"
  bucket_name              = "sec-audit-logs-prod-1026"
  environment              = "prod"
  enable_cloudtrail_access = true
}

module "account_audit_trail" {
  source       = "../../modules/audit-cloudtrail"
  trail_name   = "org-management-audit-trail-prod"
  s3_bucket_id = module.audit_log_storage.bucket_id
  environment  = "prod"

  depends_on = [module.audit_log_storage]
}