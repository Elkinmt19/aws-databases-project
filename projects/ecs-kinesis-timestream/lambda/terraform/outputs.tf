output "lambda_function_name" {
    value = aws_lambda_function.lambda_get_kds_events_function.function_name
}
output "lambda_function_arn" {
    value = aws_lambda_function.lambda_get_kds_events_function.arn
}