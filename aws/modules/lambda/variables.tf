variable "project" {
  type = string
  description = "Define a tag for the projects"
}

variable "environment" {
  type = string
  description = "Define a tag for the environments"
}

variable "private_subnet" {
    type = list(string)
    description = "IP Range for private subnet"
}

variable "lambda_sg" {
  type = string
  description = "SG value"
}

variable "s3_function" {
  type = string
  description = "ARN of the Lambda function triggered by S3 events"
}