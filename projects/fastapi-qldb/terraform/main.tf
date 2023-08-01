module "qldb_ledger" {
  providers = {
    aws.main = aws.main
  }
  source                   = "../modules/qldb/"
  project_name             = var.project_name
  ledger_name              = "${var.ledger_name}-${var.project_name}"
  qldb_permissions_mode    = var.qldb_permissions_mode
  qldb_deletion_protection = var.qldb_deletion_protection
  qldb_tags                = var.qldb_tags
  env                      = var.env
}

module "qldb_s3_bucket_export" {
  providers = {
    aws.main = aws.main
  }
  source       = "../modules/s3_export/"
  project_name = var.project_name
  ledger_name  = "${var.ledger_name}-${var.project_name}"
  aws_account  = var.aws_account
  env          = var.env
}
