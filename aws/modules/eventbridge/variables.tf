variable "septa_workflow" {
  type = string
  description = "ARN of the Step Function workflow"
}

variable "project" {
  type = string
  description = "Define a tag for the projects"
}

variable "environment" {
  type = string
  description = "Define a tag for the environments"
}