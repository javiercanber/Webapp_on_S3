resource "aws_cloudwatch_event_rule" "s3_upload" {
  name        = "s3-upload-rule"
  description = "Trigger on S3 object upload events"

  event_pattern = jsonencode({
    source = ["aws.s3"]
    detail_type = ["Object Created"]
    detail = {
      bucket = {
        name = ["webapp-septa-2025"]
      }
    }
  })
}

# AWS EventBridge Target
resource "aws_cloudwatch_event_target" "s3_to_lambda" {
  rule      = aws_cloudwatch_event_rule.s3_upload.name
  arn       = var.septa_workflow
  role_arn = aws_iam_role.eventbridge_role.arn
}