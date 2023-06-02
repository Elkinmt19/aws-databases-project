variable "project_name" {
    type = string
    default = "ecs-kinesis-timestream"
}
variable "env" {
    type = string
    default = "qa"
}

variable "kds_name" {
    type = string
    default = "football_player_stream"
}