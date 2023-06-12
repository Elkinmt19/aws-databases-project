variable "project_name" {
    type = string
    default = "ecs-kinesis-timestream"
}
variable "env" {
    type = string
    default = "qa"
}
variable "service" {
    type = string
    default = "data-producer"
}
variable "aws_region" {
    type = string
    default = "us-east-1"
}
variable "ecs_cluster" {
    type = string
    default = "ecs-kinesis-timestream-qa-cluster"
}
variable "vpc_id" {
    type = string
    default = "vpc-04e57817f5095432d"
}
variable "private_subnets" {
    type = list(string)
    default = ["10.10.192.0/19","10.10.224.0/19"]
}
variable "public_subnets" {
    type = list(string)
    default = ["10.10.0.0/17","10.10.128.0/18"]
}
variable "kds_arn" {
    type = string
    default = "football_player_stream"
}