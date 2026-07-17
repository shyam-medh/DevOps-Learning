resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "remote-infra-dynamodb-table-shyam"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "remote-infra-dynamodb-table-shyam"
    Environment = "production"
  }
}