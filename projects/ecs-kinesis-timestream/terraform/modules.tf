# Data Producer Service Module Configuration
module "data_producer_module" {
    source  = "../data-producer/terraform"
    project_name = var.project_name
    env = var.env
    service = var.data_producer_service
    aws_region = var.aws_region
    ecs_cluster = aws_ecs_cluster.aws-ecs-cluster.id
    vpc_id = aws_vpc.aws-vpc.id
    private_subnets = aws_subnet.private.*.id
    public_subnets = aws_subnet.public.*.id
    kds_arn = module.kinesis_datastream_module.kinesis_stream_arn
}

# Kinesis DataStream Module Configuration 
module "kinesis_datastream_module" {
    source = "../kinesis-datastream/terraform"
    project_name = var.project_name
    env = var.env
    kds_name = var.kds_name
}

# TimeStream Module Configuration
module "timestream_module" {
    source = "../timestream/terraform"
    project_name = var.project_name
    env = var.env
    timestream_db_name = var.timestream_db_name
    timestream_table_name = var.timestream_table_name
}

# Lambda Function Configuration
module "lambda_function_module" {
    source = "../lambda/terraform"
    project_name = var.project_name
    env = var.env
    lambda_function_name = var.lambda_function_name
    timestream_db_name = module.timestream_module.timestream_db_name
    timestream_table_name = module.timestream_module.timestream_table_name
    timestream_table_arn = module.timestream_module.timestream_table_arn
    kds_arn = module.kinesis_datastream_module.kinesis_stream_arn
}

# Grafana Service Module Configuration
module "grafana_module" {
    source  = "../grafana/terraform"
    project_name = var.project_name
    env = var.env
    service = var.grafana_service
    aws_region = var.aws_region
    ecs_cluster = aws_ecs_cluster.aws-ecs-cluster.id
    vpc_id = aws_vpc.aws-vpc.id
    private_subnets = aws_subnet.private.*.id
    public_subnets = aws_subnet.public.*.id
    timestream_table_arn = module.timestream_module.timestream_table_arn
}