resource "aws_iam_role" "qldb_s3_export_role" {
  provider = aws.main
  name     = "QLDBTutorialJournalExportRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "qldb.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "qldb_policy" {
  name        = "QLDBS3ExportPolicy"
  description = "Policy para exportar Journal de QLDB hacia S3"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObjectAcl",
          "s3:PutObject"
        ]
        Resource = ["arn:aws:qldb"]
      },
      {
        Effect   = "Allow"
        Action   = "qldb:TagResource"
        Resource = "arn:aws:s3:::${aws_s3_bucket.qldb_s3_bucket_export.bucket}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "qldb_attachment" {
  policy_arn = aws_iam_policy.qldb_policy.arn
  role       = aws_iam_role.qldb_s3_export_role.name
}
