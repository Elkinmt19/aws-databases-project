# Data Producer Service Configuration
module "data_producer_module" {
    source  = "../data-producer/terraform"
    project_name = var.project_name
    env = var.env
    service = "data-producer"
    aws_region = var.aws_region
    ecs_cluster = aws_ecs_cluster.aws-ecs-cluster.id
    vpc_id = aws_vpc.aws-vpc.id
    private_subnets = aws_subnet.private.*.id
    public_subnets = aws_subnet.public.*.id
}