resource "aws_qldb_ledger" "ledger" {

  depends_on = [
    aws_iam_role.qldb_role
  ]

  name                = var.ledger_name
  permissions_mode    = var.qldb_permissions_mode
  deletion_protection = var.qldb_deletion_protection
  tags                = var.qldb_tags
}
