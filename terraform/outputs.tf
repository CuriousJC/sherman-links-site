output "index_etag" {
  description = "has of file contents"
  value       = aws_s3_object.links_sherman_index_file.etag
}

output "bucket_website_endpoint" {
  value = aws_s3_bucket.links-sherman.website_endpoint
}

output "bucket_arn" {
  value = aws_s3_bucket.links-sherman.arn
}

output "bucket_region_domain_name" {
  value = aws_s3_bucket.links-sherman.bucket_regional_domain_name
}
