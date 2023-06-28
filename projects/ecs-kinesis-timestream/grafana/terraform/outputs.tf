output "aws_ecr_repository_url" {
  value = aws_ecr_repository.aws-ecr.repository_url
}
output "aws_ecs_task_definition_id" {
  value = aws_ecs_task_definition.aws-ecs-task.id
}
