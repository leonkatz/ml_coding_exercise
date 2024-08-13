module "s3_kms_key" {
  source   = "./../kms_key"
  kms_name = var.bucket_name
  region   = var.region
}


resource "aws_s3_bucket" "base_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "ownership_controls" {
  bucket = aws_s3_bucket.base_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_versioning" "bucket" {
  bucket = aws_s3_bucket.base_bucket.id
  versioning_configuration {
    status = var.versioning == true ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_acl" "bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.ownership_controls]
  bucket     = aws_s3_bucket.base_bucket.id
  acl        = var.acl
}


resource "aws_s3_bucket_lifecycle_configuration" "bucket" {
  count  = var.enable_transition == true ? 1 : 0
  bucket = aws_s3_bucket.base_bucket.id

  rule {
    id     = "default"
    status = "Enabled"
    filter {
      prefix = var.prefix
    }

    dynamic "transition" {
      for_each = compact([var.transition_days_ia])

      content {
        days          = var.transition_days_ia
        storage_class = "STANDARD_IA"
      }
    }

    dynamic "transition" {
      for_each = compact([var.transition_days_glacier])

      content {
        days          = var.transition_days_glacier
        storage_class = "GLACIER"
      }
    }

    dynamic "expiration" {
      for_each = compact([var.expiration_days])

      content {
        days = var.expiration_days
      }
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket" {
  count  = var.encrypted == true ? 1 : 0
  bucket = aws_s3_bucket.base_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.sse_algorithm == "aws:kms" ? module.s3_kms_key.arn : null
      sse_algorithm     = var.sse_algorithm
    }
  }
}

resource "aws_s3_bucket_website_configuration" "bucket" {
  count  = var.static_website == true ? 1 : 0
  bucket = aws_s3_bucket.base_bucket.id

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document
  }
}

resource "aws_s3_bucket_object_lock_configuration" "bucket" {
  count  = var.object_lock_enabled == true ? 1 : 0
  bucket = aws_s3_bucket.base_bucket.id

  rule {
    default_retention {
      mode = var.object_lock_mode
      days = var.object_lock_days
    }
  }
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  count  = var.public_access_block_enabled == true ? 1 : 0
  bucket = aws_s3_bucket.base_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}