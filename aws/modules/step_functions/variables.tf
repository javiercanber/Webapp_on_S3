variable "s3_function" {
  type = string
  description = "ARN of the Lambda function triggered by S3 events"
}

variable "project" {
  type = string
  description = "Define a tag for the projects"
}

variable "environment" {
  type = string
  description = "Define a tag for the environments"
}

variable "septa_workflow" {
  type = string
  description = "ARN of the Step Function workflow"
}