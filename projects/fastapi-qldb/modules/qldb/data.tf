data "aws_caller_identity" "current" {
  provider = aws.main
}

data "aws_region" "current" {
  provider = aws.main
}
