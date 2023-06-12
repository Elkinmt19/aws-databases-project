output "timestream_db_name" {
    value = aws_timestreamwrite_database.timestream_db.database_name
}
output "timestream_table_name" {
    value = aws_timestreamwrite_table.timestream_table.table_name
}