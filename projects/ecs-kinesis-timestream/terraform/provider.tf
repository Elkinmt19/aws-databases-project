terraform {
  required_version = "1.4.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.59.0"
    }
  }
  backend "s3" {
    bucket = "tfstate-backend-${var.project_name}-${data.aws_caller_identity.current.account_id}-${var.env}"
    key    = "ecs-kinesis-timestream/terraform.tfstate"
    region = var.aws_region
    #dynamodb_table = "terraform_state"
    encrypt = true
    #profile        = "default"
  }
}
