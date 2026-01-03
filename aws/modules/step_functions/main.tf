resource "aws_sfn_state_machine" "septa_workflow" {
  name     = "septa-process-workflow"
  role_arn = aws_iam_role.sfn_role.arn

 definition = jsonencode({
    StartAt = "ProcesarArchivo",
    States = {
      ProcesarArchivo = {
        Type     = "Task",
        Resource = var.s3_function,
        End      = true
      }
    }
  })
}