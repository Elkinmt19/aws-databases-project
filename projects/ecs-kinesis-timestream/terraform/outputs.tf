output "vpc_id" {
  value = aws_vpc.aws-vpc.id
}
output "ecs_cluster_id" {
  value = aws_ecs_cluster.aws-ecs-cluster.id
}
output "aws_ecr_repository_url_data_producer" {
  value = module.data_producer_module.aws_ecr_repository_url
}

output "aws_ecr_repository_url_grafana" {
  value = module.grafana_module.aws_ecr_repository_url
}

output "aws_ecs_task_definition_id" {
  value = module.data_producer_module.aws_ecs_task_definition_id
}
