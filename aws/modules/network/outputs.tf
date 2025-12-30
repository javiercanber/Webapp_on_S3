# ./modules/network/outputs.tf
output "private_subnet_id" {
  value = aws_subnet.lambda_private_subnet.id
}

output "lambda_security_group" {
  value = aws_security_group.lambda_sg.id
}