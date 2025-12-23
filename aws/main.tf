# Provider info

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}

provider "aws" {

    region = var.aws_region
}

# S3 Module

module "s3_website" {
    
    source = "/aws/modules/s3"

    environment = var.environment
    project = var.project
  
}