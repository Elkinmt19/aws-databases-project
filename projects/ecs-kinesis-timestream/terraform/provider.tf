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
  }
}
