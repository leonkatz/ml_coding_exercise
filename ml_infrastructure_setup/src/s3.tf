module "s3_ml_data_bucket" {
  source         = "./../../modules/s3"
  bucket_name    = "${var.your_name}-hadrian-ml-data-bucket"
  acl            = "private"
  encrypted      = true
  versioning     = true
  static_website = false
  region         = var.region
}
