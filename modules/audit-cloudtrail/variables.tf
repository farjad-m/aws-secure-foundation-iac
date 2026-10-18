variable "trail_name" {
  description = "Name of the AWS CloudTrail trail"
  type        = string
}

variable "s3_bucket_id" {
  description = "ID of the hardened S3 bucket storing the audit logs"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}