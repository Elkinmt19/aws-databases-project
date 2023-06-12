# Timestream DataBase Configuration
resource "aws_timestreamwrite_database" "timestream_db" {
    database_name = var.timestream_db_name
    tags = {
        name = "${var.project_name}-timestream-db"
        env = var.env
    }
}
resource "aws_timestreamwrite_table" "timestream_table" {
    database_name = aws_timestreamwrite_database.timestream_db.database_name
    table_name    =  var.timestream_table_name
    retention_properties {
        magnetic_store_retention_period_in_days = 30
        memory_store_retention_period_in_hours  = 8
    }
    tags = {
        name = "${var.project_name}-timestream-db"
        env = var.env
    }
}