variable "bucket_name" {
  description = "Globally unique name for the S3 bucket"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "enable_cloudtrail_access" {
  description = "Allow AWS CloudTrail service to write audit logs to this bucket"
  type        = bool
  default     = false
}