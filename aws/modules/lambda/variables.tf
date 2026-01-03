variable "project" {
  type = string
  description = "Define a tag for the projects"
}

variable "environment" {
  type = string
  description = "Define a tag for the environments"
}

variable "private_subnet_id" {
  type = list(string)
  description = "List of private subnet IDs where the Lambda function will be deployed"
}

variable "lambda_security_group" {
  type = string
  description = "Security group ID to be associated with the Lambda function"
  
}