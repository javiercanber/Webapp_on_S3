# Create a S3 bucket

resource "aws_s3_bucket" "webapp_bucket" {
  bucket = "Webapp-2025"

  tags = {
    project = var.project
    environment = var.environment
  }
}

# Define S3 as a static website hosting

resource "aws_s3_bucket_website_configuration" "webapp_config" {
  bucket = aws_s3_bucket.webapp_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

# Allow public access to S3

resource "aws_s3_bucket_public_access_block" "webapp_access" {
  bucket = aws_s3_bucket.webapp_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

}

##