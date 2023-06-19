output "kinesis_stream_name" {
    description = "The Kinesis Data Stream name"
    value = aws_kinesis_stream.kinesis_stream.name
}
output "kinesis_stream_arn" {
    description = "The Kinesis Data Stream ARN"
    value = aws_kinesis_stream.kinesis_stream.arn
}