resource "aws_dynamodb_table" "bad_name" {
  count = var.enable_failure_demo ? 1 : 0

  name         = "ab" # fails on apply
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "${local.name}-bad-name"
  }
}
