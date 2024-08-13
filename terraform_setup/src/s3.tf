module "terraform-state-s3" {
  source         = "./../../modules/s3"
  bucket_name    = "hadrian-project-terraform-state-bucket"
  acl            = "private"
  encrypted      = true
  versioning     = true
  static_website = false
  region         = var.region
}