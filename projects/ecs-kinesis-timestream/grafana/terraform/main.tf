# Elastic Container Repository Configuration
resource "aws_ecr_repository" "aws-ecr" {
    name = "${var.project_name}-${var.service}-${var.env}-ecr"
    tags = {
        name = "${var.project_name}-${var.service}-ecr"
        env = var.env
    }
}

# IAM Role Policies Configuration
resource "aws_iam_role" "ecsTaskExecutionRole" {
    name = "${var.project_name}-${var.service}-execution-task-role"
    assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
    tags = {
        name = "${var.project_name}-${var.service}-iam-role"
        env = var.env
    }
}
resource "aws_iam_policy" "get_timestream_role_policy" {
    name = "${var.project_name}-${var.service}-get-timestream-policy"
    policy = data.aws_iam_policy_document.get_timestream_role_policy.json
    tags = {
        name = "${var.project_name}-${var.service}-iam-policy"
        env = var.env
    }
}
resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
    role = aws_iam_role.ecsTaskExecutionRole.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
resource "aws_iam_role_policy_attachment" "get_timestream_role_policy_attach" {
    role = aws_iam_role.ecsTaskExecutionRole.name
    policy_arn = aws_iam_policy.get_timestream_role_policy.arn
}

# CloudWatch Configuration
resource "aws_cloudwatch_log_group" "log-group" {
	name = "${var.project_name}-${var.service}-${var.env}-logs"
	tags = {
		name = var.project_name
		env = var.env
	}
}

# Task Definition Configuration
resource "aws_ecs_task_definition" "aws-ecs-task" {
    family = "${var.project_name}-${var.service}-task"
    container_definitions = <<DEFINITION
    [
        {
        "name": "${var.project_name}-${var.service}-${var.env}-container",
        "image": "${aws_ecr_repository.aws-ecr.repository_url}:latest",
        "entryPoint": [],
        "environment": [
            {
                "name": "GF_SERVER_ROOT_URL",
                "value": "http://my.grafana.server/"
            },
            {
                "name": "GF_INSTALL_PLUGINS",
                "value": "grafana-clock-panel,grafana-iot-twinmaker-app,grafana-timestream-datasource"
            }
        ],
        "essential": true,
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
            "awslogs-group": "${aws_cloudwatch_log_group.log-group.id}",
            "awslogs-region": "${var.aws_region}",
            "awslogs-stream-prefix": "${var.project_name}-${var.service}-${var.env}"
            }
        },
        "portMappings": [
            {
            "containerPort": 3000,
            "hostPort": 3000
            }
        ],
        "cpu": 256,
        "memory": 512,
        "networkMode": "awsvpc"
        }
    ]
    DEFINITION
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    memory = "512"
    cpu = "256"
    execution_role_arn = aws_iam_role.ecsTaskExecutionRole.arn
    task_role_arn = aws_iam_role.ecsTaskExecutionRole.arn
    tags = {
        name = "${var.project_name}-${var.service}-ecs-td"
        env = var.env
    }
}

# ECS Service Configuration
resource "aws_ecs_service" "aws-ecs-service" {
    name = "${var.project_name}-${var.service}-${var.env}-ecs-service"
    cluster = var.ecs_cluster
    task_definition = "${aws_ecs_task_definition.aws-ecs-task.family}:${max(aws_ecs_task_definition.aws-ecs-task.revision, data.aws_ecs_task_definition.main.revision)}"
    launch_type = "FARGATE"
    scheduling_strategy  = "REPLICA"
    desired_count = 1
    force_new_deployment = true
    network_configuration {
        subnets = var.private_subnets
        assign_public_ip = false
        security_groups = [aws_security_group.service_security_group.id]
    }
    load_balancer {
        target_group_arn = aws_lb_target_group.target_group.arn
        container_name = "${var.project_name}-${var.service}-${var.env}-container"
        container_port = 3000
    }
    depends_on = [aws_lb_listener.listener]
    tags = {
        name = "${var.project_name}-${var.service}-ecs-td"
        env = var.env
    }
}

# Application Load Balancer Configuration
resource "aws_alb" "application_load_balancer" {
    name = "${var.service}-${var.env}-alb"
    internal = false
    load_balancer_type = "application"
    subnets = var.public_subnets
    security_groups = [aws_security_group.load_balancer_security_group.id]
    idle_timeout = 600
    tags = {
        name = "${var.project_name}-alb"
        env = var.env
    }
}
resource "aws_lb_target_group" "target_group" {
    name = "${var.service}-${var.env}-tg"
    port = 80
    protocol = "HTTP"
    target_type = "ip"
    vpc_id = var.vpc_id
    health_check {
        healthy_threshold = "3"
        interval = "300"
        protocol = "HTTP"
        matcher = "200"
        timeout = "3"
        path = "/v1/status"
        unhealthy_threshold = "2"
    }
    tags = {
        name = "${var.project_name}-lb-tg"
        env = var.env
    }
}
resource "aws_lb_listener" "listener" {
    load_balancer_arn = aws_alb.application_load_balancer.id
    port = "80"
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.target_group.id
    }
}

# VPC Security Group Configuration
resource "aws_security_group" "service_security_group" {
    vpc_id = var.vpc_id
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        security_groups = [aws_security_group.load_balancer_security_group.id]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    tags = {
        name = "${var.project_name}-service-sg"
        env = var.env
    }
}
resource "aws_security_group" "load_balancer_security_group" {
    vpc_id = var.vpc_id
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    tags = {
        name = "${var.project_name}-sg"
        env = var.env
    }
}