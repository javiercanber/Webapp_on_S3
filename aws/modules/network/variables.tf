variable "cidr_block" {
    type = string
    description = "IP Range for main VPC"
}

variable "private_subnet" {
    type = list(string)
    description = "IP Range for private subnet"
}

variable "project" {
  type = string
  description = "Define a tag for the projects"
}

variable "environment" {
  type = string
  description = "Define a tag for the environments"
}