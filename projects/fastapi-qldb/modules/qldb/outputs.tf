output "ledger_arn" {
  description = "ARN del ledger QLDB creado"
  value       = aws_qldb_ledger.ledger.arn
}

output "ledger_tags" {
  description = "ARN del ledger QLDB creado"
  value       = aws_qldb_ledger.ledger.tags_all
}
