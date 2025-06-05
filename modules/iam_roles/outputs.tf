output "task_execution_role_arn" {
  description = "ARN der ECS Execution Role (Containerstart, Logs, Secrets)"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "task_role_arn" {
  description = "ARN der ECS Task Role (App Zugriff auf S3, Secrets etc.)"
  value       = aws_iam_role.ecs_task.arn
}
