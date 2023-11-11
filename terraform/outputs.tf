output "bucket_website_endpoint" {
  value = aws_s3_bucket.links-sherman.website_endpoint
}

output "bucket_arn" {
  value = aws_s3_bucket.links-sherman.arn
}

output "bucket_region_domain_name" {
  value = aws_s3_bucket.links-sherman.bucket_regional_domain_name
}

output "variable_output_test" {
  value = var.some_secret
}
