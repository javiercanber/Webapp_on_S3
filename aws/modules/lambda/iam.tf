# Execution Role for AWS Lambda
resource "aws_iam_role" "lambda_exec_role" {
    
    name = "septa-lambda-role"

    assume_role_policy = jsondecode({
        Version = "2012-10-17"
        Statement = [{
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal ={ Service = "lambda.amazonaws.com" }

        }]
    })
}

# Allow lambdda_exec_role access to VPC
resource "aws_iam_role_policy_attachment" "lambda-attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

# Allow AWS Lambda service to send logs to CloudWatch

resource "aws_iam_policy" "lambda_write_log" {
  name        = "LambdaWriteLogToCloudWatch"
  description = "Allow AWS Lambda Resource send logs to CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "logs:CreateLogGroup",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

