provider "aws" {
	profile = "poc_personalize"
	region = "us-east-1"
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
		bucket = "terraform-state-backend-aws-database-project"
		key = "ecs-kinesis-timestream/terraform.tfstate"
		region = "us-east-1"
		dynamodb_table = "terraform_state"
		encrypt = true
		profile = "poc_personalize"
	}
}
