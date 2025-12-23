resource "aws_iam_user" "s3_admin" {
  name = "s3_admin"

  tags = {
    project = var.project
    environment = var.environment
  }
}

resource "aws_iam_policy" "s3_create_policy" {
  name        = "S3CreateBucketPolicy"
  description = "Allow creation of S3 buckets."

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

resource "aws_iam_user_policy_attachment" "s3_policy_attachment" {

  user = aws_iam_user.s3_admin.name
  policy_arn = aws_iam_policy.s3_create_policy.arn

}