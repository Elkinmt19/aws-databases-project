terraform {
  required_version = "1.4.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.59.0"
    }
  }
  backend "s3" {
    bucket = "terraform-state-backend-ecs-kinesis-timestream"
    key    = "ecs-kinesis-timestream/terraform.tfstate"
    region = "us-east-1"
    #dynamodb_table = "terraform_state"
    encrypt = true
    #profile        = "default"
  }
}
