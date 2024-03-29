variable "project_name" {
    type = string
    default = "ecs-kinesis-timestream"
}
variable "env" {
    type = string
    default = "qa"
}
variable "timestream_db_name" {
    type = string
    default = "football_player_timestream_db"
}
variable "timestream_table_name" {
    type = string
    default = "football_player_timestream_table"
}