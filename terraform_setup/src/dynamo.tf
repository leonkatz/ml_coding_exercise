resource "aws_dynamodb_table" "terraform-state-lock" {
  name           = "terraform-state-lock"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    "Name" = "DynamoDB Terraform Backend State Lock Table"
  }
}
