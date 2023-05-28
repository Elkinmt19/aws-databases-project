output "vpc_id" {
    value = aws_vpc.aws-vpc.id
}
output "ecs_cluster_id" {
    value = aws_ecs_cluster.aws-ecs-cluster.id
}