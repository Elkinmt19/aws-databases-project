terraform {
  required_version = ">= 1.4.6"
  backend "s3" {
    encrypt = true
  }
}

provider "aws" {
  alias   = "main"
  profile = "default"
  region  = "us-east-1"
}
