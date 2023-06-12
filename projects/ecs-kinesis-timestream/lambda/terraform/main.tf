# IAM Role Policies Configuration
resource "aws_iam_role" "lambdaExecutionRole" {
    name = "${var.project_name}-lambda-execution-task-role"
    assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
    tags = {
        name = "${var.project_name}-lambda-iam-role"
        env = var.env
    }
}
resource "aws_iam_policy" "lambda_logging_role_policy" {
    name = "${var.project_name}-lambda-logging-events-policy"
    policy = data.aws_iam_policy_document.lambda_logging_role_policy.json
    tags = {
        name = "${var.project_name}-lambda-iam-policy"
        env = var.env
    }
}
resource "aws_iam_policy" "lambda_get_kds_events_role_policy" {
    name = "${var.project_name}-lambda-get-kds-events-policy"
    policy = data.aws_iam_policy_document.lambda_get_kds_events_role_policy.json
    tags = {
        name = "${var.project_name}-lambda-iam-policy"
        env = var.env
    }
}
resource "aws_iam_role_policy_attachment" "lambda_logging_role_policy_attach" {
    role = aws_iam_role.lambdaExecutionRole.name
    policy_arn = aws_iam_policy.lambda_logging_role_policy.arn
}
resource "aws_iam_role_policy_attachment" "lambda_get_kds_events_role_policy_attach" {
    role = aws_iam_role.lambdaExecutionRole.name
    policy_arn = aws_iam_policy.lambda_get_kds_events_role_policy.arn
}

# Lambda Function Configuration
    resource "aws_lambda_function" "lambda_get_kds_events_function" {
    function_name = var.lambda_function_name
    filename = "../lambda/lambda_function_payload.zip"
    source_code_hash = data.archive_file.lambda_code.output_base64sha256
    handler = "insert_data_timestream.lambda_handler"
    role = aws_iam_role.lambdaExecutionRole.arn
    runtime = "python3.9"
    timeout = 30
    environment {
        variables = {
            TIMESTREAM_DB_NAME = var.timestream_db_name
            TIMESTREAM_TABLE_NAME = var.timestream_table_name
        }
    }
    tags = {
        name = "${var.project_name}-lambda-function"
        env = var.env
    }
}
resource "aws_lambda_event_source_mapping" "lambda_event_trigger" {
    event_source_arn  = var.kds_arn
    function_name = aws_lambda_function.lambda_get_kds_events_function.arn
    starting_position = "LATEST"
}