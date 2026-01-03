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
    
    source = "./modules/s3"

    environment = var.environment
    project = var.project
  
}

# Networking Module

module "network_septa" {

    source = "./modules/network"

    private_subnet = var.private_subnet[0]
    cidr_block = var.cidr_block
    environment = var.environment
    project = var.project

}

# Lambda Module

module "lambda_septa" {
  
  source = "./modules/lambda"

  project = var.project
  environment = var.environment

  private_subnet_id = [module.network_septa.private_subnet_id] 
  lambda_security_group = module.network_septa.lambda_security_group

}

module "sfn_septa" {
  
  source = "./modules/step_functions"

  s3_function = module.lambda_septa.s3_function
  project = var.project
  environment = var.environment
  
}

module septa-event {

    source = "./modules/eventbridge"
    septa_workflow = module.sfn_septa.septa_workflow
    environment = var.environment
    project = var.project
}