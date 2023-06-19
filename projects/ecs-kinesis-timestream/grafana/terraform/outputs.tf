output "aws_ecr_repository_id" {
    value = aws_ecr_repository.aws-ecr.id
}
output "aws_ecs_task_definition_id" {
    value = aws_ecs_task_definition.aws-ecs-task.id
}