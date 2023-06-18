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
data "aws_iam_policy_document" "get_timestream_role_policy" {
    statement {
        effect = "Allow"
        actions = [
            "timestream:Select",
            "timestream:DescribeTable",
            "timestream:ListMeasures"
        ]
        resources = [var.timestream_table_arn]
    }
    statement {
        effect = "Allow"
        actions = [
            "timestream:CancelQuery",
            "timestream:DescribeDatabase",
            "timestream:DescribeEndpoints",
            "timestream:DescribeTable",
            "timestream:ListDatabases",
            "timestream:ListMeasures",
            "timestream:ListTables",
            "timestream:ListTagsForResource",
            "timestream:Select",
            "timestream:SelectValues",
            "timestream:DescribeScheduledQuery",
            "timestream:ListScheduledQueries"                
        ]
        resources = ["*"]
    }
}

# Task Definition Configuration
data "aws_ecs_task_definition" "main" {
    task_definition = aws_ecs_task_definition.aws-ecs-task.family
}