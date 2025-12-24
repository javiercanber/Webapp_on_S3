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

# 4. Crear la política para denegar el acceso a todos excepto a un rango de IP's
resource "aws_s3_bucket_policy" "deny_public_access" {
  bucket = aws_s3_bucket.s3_septa_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyPublicReadGetObject"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.s3_septa_bucket.arn}/*"
        Condition = {
          NotIpAddress = {
            "aws:SourceIp" = ["192.168.1.23/32"]
          }
        }
      }
    ]
  })
  
  # Dependencia para asegurar que el bloqueo de acceso público se quite antes
  depends_on = [aws_s3_bucket_public_access_block.public_access]
}
