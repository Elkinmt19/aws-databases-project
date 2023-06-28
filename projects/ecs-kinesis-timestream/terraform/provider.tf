provider "aws" {
  profile = "default"
  region  = "us-east-1"
}
terraform {
  required_version = "1.4.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.59.0"
    }
  }
  backend "s3" {
    bucket = "tfstate-backend-157098863241-qa"
    key    = "terraform.tfstate"
    region = "us-east-1"
    #dynamodb_table = "terraform_state"
    encrypt = true
    profile = "default"
  }
}
