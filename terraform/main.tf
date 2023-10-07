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

resource "aws_s3_object" "index_file" {
  bucket       = aws_s3_bucket.sherman-tf-public.id
  key          = "index.html"         # The desired object key (file name) in the bucket
  source       = "../site/index.html" # Local path to your index.html file
  content_type = "text/html"          # Specify the content type if needed
  acl          = "public-read"        # Set ACL to make the object publicly readable
  etag         = filemd5("../site/index.html")
}


################


resource "aws_s3_bucket" "links-sherman" {
  bucket = "links.sherman.industries"
}

resource "aws_s3_bucket_ownership_controls" "links-sherman" {
  bucket = aws_s3_bucket.links-sherman.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_public_access_block" "links-sherman" {
  bucket = aws_s3_bucket.links-sherman.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "links-sherman" {
  depends_on = [
    aws_s3_bucket_ownership_controls.links-sherman,
    aws_s3_bucket_public_access_block.links-sherman,
  ]

  bucket = aws_s3_bucket.links-sherman.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "links-sherman" {
  bucket = aws_s3_bucket.links-sherman.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

resource "aws_s3_object" "links_sherman_index_file" {
  bucket       = aws_s3_bucket.links-sherman.id
  key          = "index.html"         # The desired object key (file name) in the bucket
  source       = "../site/index.html" # Local path to your index.html file
  content_type = "text/html"          # Specify the content type if needed
  acl          = "public-read"        # Set ACL to make the object publicly readable
  etag         = filemd5("../site/index.html")
}
