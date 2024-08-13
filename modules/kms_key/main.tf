

resource "aws_kms_key" "kms_key" {
  description             = "${var.kms_name} kms key"
  enable_key_rotation     = var.enable_key_rotation
  deletion_window_in_days = var.deletion_window_in_days
  policy                  = data.aws_iam_policy_document.kms_policy.json
  tags                    = var.tags
}

resource "aws_kms_alias" "kms_alias" {
  name          = var.alias != null ? var.alias : "alias/${replace(var.kms_name, ".", "-")}"
  target_key_id = aws_kms_key.kms_key.id
}
