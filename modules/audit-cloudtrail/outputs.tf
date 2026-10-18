output "cloudtrail_arn" {
  value = aws_cloudtrail.this.arn
}

output "cloudtrail_home_region" {
  value = aws_cloudtrail.this.home_region
}