resource "aws_s3_bucket_policy" "sw_bucket_policy" {
  count  = var.apply_default_policy == true ? 1 : 0
  bucket = aws_s3_bucket.base_bucket.id
  policy = var.public_read_policy == true ? data.aws_iam_policy_document.sw_bucket_policy_document.json : data.aws_iam_policy_document.default_bucket_policy_document.json
}

data "aws_iam_policy_document" "sw_bucket_policy_document" {
  statement {
    sid     = "PublicReadGetObject"
    actions = ["s3:GetObject"]
    effect  = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    resources = ["${aws_s3_bucket.base_bucket.arn}/*"]
  }
  statement {
    sid     = "AllowSSLRequestsOnly"
    actions = ["s3:*"]
    effect  = "Deny"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    resources = [
      aws_s3_bucket.base_bucket.arn,
      "${aws_s3_bucket.base_bucket.arn}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

data "aws_iam_policy_document" "default_bucket_policy_document" {
  statement {
    sid     = "AllowSSLRequestsOnly"
    actions = ["s3:*"]
    effect  = "Deny"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    resources = [
      aws_s3_bucket.base_bucket.arn,
      "${aws_s3_bucket.base_bucket.arn}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}
