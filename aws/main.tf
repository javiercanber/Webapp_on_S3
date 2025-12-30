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
    environment = var.environment
    project = var.project
    cidr_block = var.cidr_block

}

# Lambda Module

module "lambda_septa" {
  
  source = "./modules/lambda"

  project = var.project
  environment = var.environment
  s3_function = var.s3_function

  private_subnet = [module.network_septa.private_subnet_id] 
  lambda_sg = module.network_septa.lambda_security_group

}

module "sfn_septa" {
  
  source = "./modules/step_functions"

  s3_function = module.lambda_septa.s3_function
  septa_workflow = var.septa_workflow
  project = var.project
  environment = var.environment
  
}

module septa-event {

    source = "./modules/eventbridge"
    septa_workflow = module.sfn_septa.septa_workflow
    environment = var.environment
    project = var.project
}