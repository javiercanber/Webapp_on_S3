resource "aws_s3_bucket" "s3_septa_bucket" {
  bucket = "webapp-septa-2025"

  tags = {
    project = var.project
    environment = var.environment
  }
}

# Inserta los ficheros de la Webapp dentro del bucket creado

resource "aws_s3_object" "webapp_files" {
  for_each = fileset("${path.root}/html_files/", "**/*")

  bucket       = aws_s3_bucket.s3_septa_bucket.id
  key          = each.value
  source       = "${path.root}/html_files/${each.value}"
  content_type = "text/html"
  etag         = filemd5("${path.root}/html_files/${each.value}")
}

# 2. Configurar la propiedad de sitio web
resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.s3_septa_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# 3. Deshabilitar el bloqueo de acceso público (Obligatorio para sitios web públicos)
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.s3_septa_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}