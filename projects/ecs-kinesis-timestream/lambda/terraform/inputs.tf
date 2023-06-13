variable "project_name" {
    type = string
    default = "ecs-kinesis-timestream"
}
variable "env" {
    type = string
    default = "qa"
}
variable "lambda_function_name" {
    type = string
    default = "football_player_timestream_lambda"
}
variable "timestream_db_name" {
    type = string
    default = "football_player_timestream_db"
}
variable "timestream_table_name" {
    type = string
    default = "football_player_timestream_table"
}
variable "timestream_table_arn" {
    type = string
}
variable "kds_arn" {
    type = string
}