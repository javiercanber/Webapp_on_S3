# Load .zip file for Lambda function
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.root}/html_files/index.js"
  output_path = "${path.root}/html_files/lambda_function.zip"
}


# AWS Lambda trigger by S3
resource "aws_lambda_function" "s3_function" {

  filename      = data.archive_file.lambda_zip.output_path
  function_name = "s3_processor"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "index.handler"
  runtime = "nodejs20.x"

  vpc_config {
   
   subnet_ids = var.private_subnet_id
   security_group_ids = [var.lambda_security_group]

  }

}