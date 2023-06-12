# IAM Role Policies Configuration
data "aws_iam_policy_document" "assume_role_policy" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
            type = "Service"
            identifiers = ["ecs-tasks.amazonaws.com"]
        }
    }
}
data "aws_iam_policy_document" "kds_put_event_role_policy" {
    statement {
        effect = "Allow"
        actions = ["kinesis:PutRecord"]
        resources = [var.kds_arn]
    }
}

# Task Definition Configuration
data "template_file" "env_vars" {
    template = file("env/${var.env}/env_vars.json")
}
data "aws_ecs_task_definition" "main" {
    task_definition = aws_ecs_task_definition.aws-ecs-task.family
}