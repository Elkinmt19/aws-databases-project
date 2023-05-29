variable "project_name" {
    type = string
    default = "ecs-kinesis-timestream"
}
variable "env" {
    type = string
    default = "qa"
}
variable "aws_region" {
    type = string
    default = "us-east-1"
}
variable "private_subnets" {
    type = list(string)
    default = ["10.10.192.0/19","10.10.224.0/19"]
}
variable "public_subnets" {
    type = list(string)
    default = ["10.10.0.0/17","10.10.128.0/18"]
}
variable "availability_zones" {
    type = list(string)
    default = ["us-east-1a","us-east-1b"]
}


