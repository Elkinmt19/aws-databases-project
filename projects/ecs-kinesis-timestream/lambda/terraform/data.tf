# IAM Role Policies Configuration
data "aws_iam_policy_document" "assume_role_policy" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
            type = "Service"
            identifiers = ["lambda.amazonaws.com"]
        }
    }
}
data "aws_iam_policy_document" "lambda_logging_role_policy" {
    statement {
        effect = "Allow"
        actions = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
        ]
        resources = ["arn:aws:logs:*:*:*"]
    }
}
data "aws_iam_policy_document" "lambda_get_kds_events_role_policy" {
    statement {
        effect = "Allow"
        actions = [
            "kinesis:GetRecords",
            "kinesis:GetShardIterator",
            "kinesis:DescribeStream",
            "kinesis:ListShards",
            "kinesis:ListStreams",
        ]
        resources = [var.kds_arn]
    }
}

# Lambda Function Configuration
data "archive_file" "lambda_code" {
    type = "zip"
    source_file = "../lambda/insert_data_timestream.py"
    output_path = "../lambda/lambda_function_payload.zip"
}