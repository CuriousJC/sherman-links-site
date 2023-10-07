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

# Uploads index file and specifies the proper acl so it is readable.  The etag is used to has the file and pick up changes and force a new TF apply on the resouce
resource "aws_s3_object" "links_sherman_index_file" {
  bucket       = aws_s3_bucket.links-sherman.id
  key          = "index.html"         # The desired object key (file name) in the bucket
  source       = "../site/index.html" # Local path to your index.html file
  content_type = "text/html"          # Specify the content type if needed
  acl          = "public-read"        # Set ACL to make the object publicly readable
  etag         = filemd5("../site/index.html")
}
