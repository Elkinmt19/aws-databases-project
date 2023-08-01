#!/bin/bash

export AWS_PROFILE=default
export TF_ENV=dev
export S3_TFSTATE_BUCKET=pragma-qldb-157098863241-tfbackend-${TF_ENV}
aws s3api create-bucket --bucket ${S3_TFSTATE_BUCKET} --region "us-east-1"