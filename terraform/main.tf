# Starting main here

resource "aws_s3_bucket" "sherman-tf-example" {
  bucket = "sherman-tf-example"

  tags = {
    Name = "sherman-tf-example"
  }
}

resource "aws_s3_bucket" "sherman-tf-public" {
  bucket = "sherman-tf-public"
  tags = {
    Name = "sherman-tf-public"
  }
}

resource "aws_s3_bucket_ownership_controls" "sherman-tf-public" {
  bucket = aws_s3_bucket.sherman-tf-public.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_public_access_block" "sherman-tf-public" {
  bucket = aws_s3_bucket.sherman-tf-public.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "sherman-tf-public" {
  depends_on = [
    aws_s3_bucket_ownership_controls.sherman-tf-public,
    aws_s3_bucket_public_access_block.sherman-tf-public,
  ]

  bucket = aws_s3_bucket.sherman-tf-public.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "sherman-tf-public" {
  bucket = aws_s3_bucket.sherman-tf-public.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  # redirect_all_requests_to {
  #   host_name = aws_s3_bucket.sherman-tf-public.bucket_regional_domain_name
  # }
}
