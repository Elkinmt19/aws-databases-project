output "account_id" {
  description = "Selected AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "vpc_id" {
  value = aws_vpc.aws-vpc.id
}
output "ecs_cluster_id" {
  value = aws_ecs_cluster.aws-ecs-cluster.id
}
output "aws_ecr_repository_id" {
  value = module.data_producer_module.aws_ecr_repository_id
}
output "aws_ecs_task_definition_id" {
  value = module.data_producer_module.aws_ecs_task_definition_id
}
