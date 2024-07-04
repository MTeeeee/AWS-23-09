resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "S3-Uploads"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "Time"
  range_key      = "Name"

  attribute {
    name = "Time"
    type = "S"
  }

  attribute {
    name = "Name"
    type = "S"
  }

  tags = {
    Name        = "S3-Uploads"
    Environment = "dev"
  }
}