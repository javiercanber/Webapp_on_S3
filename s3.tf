resource "aws_s3_bucket" "webapp_bucket" {
  bucket = "Webapp-2025"

  tags = {
    Name        = ""
    Environment = "Dev"
  }
}