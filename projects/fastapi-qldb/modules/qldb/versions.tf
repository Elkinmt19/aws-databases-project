terraform {
  required_version = ">=1.4.6"
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "4.59.0"
      configuration_aliases = [aws.main]
    }
  }
}