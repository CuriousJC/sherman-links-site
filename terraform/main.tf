#
# Creating an S3 bucket with static website hosting for our simple HTML webpage
#
# The name matters for CNAMEs - you have to name the bucket the same as what your public host will be.  
# So, by using "links.sherman.industries" as my bucket name I am able to have the following endpoints:
# http://links.sherman.industries.s3-website-us-east-1.amazonaws.com/
# https://links.sherman.industries/
#
resource "aws_s3_bucket" "links-sherman" {
  bucket = "links.sherman.industries"
}

#Ownership controls required for public access I guess
resource "aws_s3_bucket_ownership_controls" "links-sherman" {
  bucket = aws_s3_bucket.links-sherman.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
#Bucket-level access being opened to the world
resource "aws_s3_bucket_public_access_block" "links-sherman" {
  bucket = aws_s3_bucket.links-sherman.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


#Setting up static website configuration documents
resource "aws_s3_bucket_website_configuration" "links-sherman" {
  bucket = aws_s3_bucket.links-sherman.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

locals {
  mime_types = {
    "css"  = "text/css"
    "html" = "text/html"
    "ico"  = "image/vnd.microsoft.icon"
    "jpg"  = "image/jpeg"
    "jpeg" = "image/jpeg"
    "js"   = "application/javascript"
    "json" = "application/json"
    "map"  = "application/json"
    "png"  = "image/png"
    "svg"  = "image/svg+xml"
    "txt"  = "text/plain"
  }
}

resource "aws_s3_object" "links_sherman_site" {
  for_each = fileset("../site/", "**/*.*")

  bucket       = aws_s3_bucket.links-sherman.id
  key          = each.key
  source       = "../site/${each.key}"
  content_type = lookup(tomap(local.mime_types), element(split(".", each.key), length(split(".", each.key)) - 1))
  etag         = filemd5("../site/${each.key}")
  acl          = "public-read"
}
