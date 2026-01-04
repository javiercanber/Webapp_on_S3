# Main VPC for AWS Lambda
resource "aws_vpc" "lambda_vpc" {
  
  cidr_block = var.cidr_block

  tags = {
    environment = var.environment
    project = var.project
  }
}

# Private subnet for AWS Lambda Resource

resource "aws_subnet" "lambda_private_subnet" {
    vpc_id = aws_vpc.lambda_vpc.id
    cidr_block = var.private_subnet[0]

    tags = {
      
      environment = var.environment
      project = var.project

    }
  
}


# SG for AWS Lambda
resource "aws_security_group" "lambda_sg" {
  name = "lambda_access"
  description = "Allow access between Lambda and Step Function Resources"
  vpc_id = aws_vpc.lambda_vpc.id

  tags = {
    environment = var.environment
    project = var.project
  }

}

# Allow Ingress rules for AWS Lambda SG

resource "aws_vpc_security_group_ingress_rule" "allow_lambda_access" {
    security_group_id = aws_security_group.lambda_sg.id
    cidr_ipv4 = aws_subnet.lambda_private_subnet.cidr_block
    from_port = 6280
    ip_protocol = "tcp"
    to_port = 6280

}

# Internet Gateway for AWS Lambda VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lambda_vpc.id
}

# Route Table for AWS Lambda VPC
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.lambda_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associate Route Table with private_subnet of AWS Lambda VPC
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.lambda_private_subnet.id
  route_table_id = aws_route_table.public_rt.id
}