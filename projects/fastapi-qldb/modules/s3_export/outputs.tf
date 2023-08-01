output "s3_bucket_export" {
  description = "ARN del ledger QLDB creado"
  value       = aws_s3_bucket.qldb_s3_bucket_export.bucket
}
