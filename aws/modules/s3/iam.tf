# 1. Definir el usuario de IAM
resource "aws_iam_user" "s3_admin_user" {
  name = "terraform-s3-creator"
  tags = {
    Description = "Usuario encargado de gestionar buckets S3"
  }
}

# 2. Definir la política de IAM (Permisos)
resource "aws_iam_policy" "s3_create_policy" {
  name        = "S3CreateBucketPolicy"
  description = "Permite la creación y gestión de buckets S3"

  # Usamos jsonencode para escribir la política en formato JSON estándar de AWS
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "s3:CreateBucket",
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# 3. Vincular la política al usuario
resource "aws_iam_user_policy_attachment" "attach_s3_policy" {
  user       = aws_iam_user.s3_admin_user.name
  policy_arn = aws_iam_policy.s3_create_policy.arn
}