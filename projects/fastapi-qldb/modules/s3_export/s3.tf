resource "aws_s3_bucket" "qldb_s3_bucket_export" {

  bucket = "pragma-qldb-tutorial-journal-export-${var.aws_account}-${var.env}"
}
