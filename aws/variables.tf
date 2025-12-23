variable "aws_region" {
    type = string
    description = "Region used by AWS"
    default = "eu-west-1"
  
}

variable "environment" {
    type = string
    description = "Tag to identify project environment."
}

variable "project" {
  type = string
  description = "Tag to identify name of project."
}