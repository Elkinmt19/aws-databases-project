# VPC Configuration
resource "aws_vpc" "aws-vpc" {
    cidr_block = "10.10.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags = {
        name = "${var.project_name}-vpc"
        env = var.env
    }
}

# Network Configuration
resource "aws_internet_gateway" "aws-igw" {
	vpc_id = aws_vpc.aws-vpc.id
	tags = {
		name = "${var.project_name}-igw"
		env = var.env
	}
}
resource "aws_subnet" "private" {
	vpc_id = aws_vpc.aws-vpc.id
	count = length(var.private_subnets)
	cidr_block = element(var.private_subnets, count.index)
	availability_zone = element(var.availability_zones, count.index)
	tags = {
		name = "${var.project_name}-private-subnet-${count.index + 1}"
		env = var.env
	}
}
resource "aws_subnet" "public" {
	vpc_id = aws_vpc.aws-vpc.id
	cidr_block = element(var.public_subnets, count.index)
	availability_zone = element(var.availability_zones, count.index)
	count = length(var.public_subnets)
	map_public_ip_on_launch = true
	tags = {
		name = "${var.project_name}-public-subnet-${count.index + 1}"
		env = var.env
	}
}
resource "aws_route_table" "public" {
	vpc_id = aws_vpc.aws-vpc.id
	tags = {
		name = "${var.project_name}-routing-table-public"
		env = var.env
	}
}
resource "aws_route" "public" {
	route_table_id = aws_route_table.public.id
	destination_cidr_block = "0.0.0.0/0"
	gateway_id = aws_internet_gateway.aws-igw.id
}
resource "aws_route_table_association" "public" {
	count = length(var.public_subnets)
	subnet_id = element(aws_subnet.public.*.id, count.index)
	route_table_id = aws_route_table.public.id
}

# ECS Cluster configuration
resource "aws_ecs_cluster" "aws-ecs-cluster" {
	name = "${var.project_name}-${var.env}-cluster"
	tags = {
		name = "${var.project_name}-ecs"
		env = var.env
	}
}
resource "aws_cloudwatch_log_group" "log-group" {
	name = "${var.project_name}-${var.env}-logs"
	tags = {
		name = var.project_name
		env = var.env
	}
}