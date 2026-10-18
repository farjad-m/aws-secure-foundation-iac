data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Compliance  = "SOC2-CC6.1"
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid    = "EnforceTLSRequestsOnly"
    effect = "Deny"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.this.arn,
      "${aws_s3_bucket.this.arn}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }

  dynamic "statement" {
    for_each = var.enable_cloudtrail_access ? [1] : []
    content {
      sid    = "AWSCloudTrailAclCheck"
      effect = "Allow"
      principals {
        type        = "Service"
        identifiers = ["cloudtrail.amazonaws.com"]
      }
      actions   = ["s3:GetBucketAcl"]
      resources = [aws_s3_bucket.this.arn]
    }
  }

  dynamic "statement" {
    for_each = var.enable_cloudtrail_access ? [1] : []
    content {
      sid    = "AWSCloudTrailWrite"
      effect = "Allow"
      principals {
        type        = "Service"
        identifiers = ["cloudtrail.amazonaws.com"]
      }
      actions   = ["s3:PutObject"]
      resources = ["${aws_s3_bucket.this.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
      condition {
        test     = "StringEquals"
        variable = "s3:x-amz-acl"
        values   = ["bucket-owner-full-control"]
      }
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket     = aws_s3_bucket.this.id
  policy     = data.aws_iam_policy_document.bucket_policy.json
  depends_on = [aws_s3_bucket_public_access_block.this]
}