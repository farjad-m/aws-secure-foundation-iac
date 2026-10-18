resource "aws_cloudtrail" "this" {
  name                          = var.trail_name
  s3_bucket_name                = var.s3_bucket_id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  enable_logging                = true

  event_selector {
    read_write_type           = "All"
    include_management_events = true
  }

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Compliance  = "SOC2-CC7.2"
  }
}