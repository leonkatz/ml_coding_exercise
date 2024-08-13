data "aws_iam_policy_document" "kms_access" {
  statement {
    effect  = "Allow"
    actions = [
      "kms:DescribeKey",
      "kms:ReEncrypt",
      "kms:GenerateDataKey",
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:CreateGrant"
    ]

    resources = [
      aws_kms_key.kms_key.arn
    ]
  }
}

resource "aws_iam_policy" "kms_access" {
  name        = replace("${var.kms_name}-${var.region}-kms-access", "/", "-")
  description = "Policy to allow read and write"
  policy      = data.aws_iam_policy_document.kms_access.json
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_iam_policy_document" "kms_policy" {
  statement {
    sid       = "Enable IAM User Permissions"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["kms:*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*",
    ]

    principals {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
    }
  }
}