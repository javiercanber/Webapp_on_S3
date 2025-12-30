# AWS Lambda trigger by S3
resource "aws_lambda_function" "s3_function" {

  filename      = "lambda_function.zip"
  function_name = "s3_processor"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "index.handler"
  runtime = "nodejs20.x"

  vpc_config {
   
   subnet_ids = var.private_subnet
   security_group_ids = [var.lambda_sg]

  }

}