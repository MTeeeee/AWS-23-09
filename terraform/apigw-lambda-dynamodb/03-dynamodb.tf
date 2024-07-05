resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "tf-db"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  # range_key      = "Name"

  attribute {
    name = "id"
    type = "S"
  }


  tags = {
    Name        = "tf-db"
    Environment = "dev"
  }
}