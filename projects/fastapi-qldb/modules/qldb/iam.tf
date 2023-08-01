resource "aws_iam_role" "qldb_role" {
  provider = aws.main
  name     = "role-${var.project_name}"
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
  name        = "QLDBPolicy"
  description = "Policy para la interacción con recursos de QLDB"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "qldb:CreateLedger",
          "qldb:DeleteLedger",
          "qldb:DescribeLedger",
          "qldb:ListLedgers",
          "qldb:UpdateLedger"
        ]
        Resource = ["arn:aws:qldb"]
      },
      {
        Effect   = "Allow"
        Action   = "qldb:TagResource"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "qldb_attachment" {
  policy_arn = aws_iam_policy.qldb_policy.arn
  role       = aws_iam_role.qldb_role.name
}
