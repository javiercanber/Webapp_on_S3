resource "aws_s3_bucket" "webapp_bucket" {
  bucket = "Webapp-2025"

  tags = {
    project = var.project
    environment = var.environment
  }
}