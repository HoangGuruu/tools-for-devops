provider "aws" {
  region = "us-east-1"
}

# resource "aws_instance" "abhishek" {
#   instance_type = "t2.micro"
#   ami = "ami-0261755bbcb8c4a84" # change this
#   subnet_id = "subnet-0f9406d3dd47449e6" # change this
# }

resource "aws_s3_bucket" "s3_bucket" {
  # bucket = "my-tf-test-bucket-1" # change this
  force_destroy = true
}

# resource "aws_dynamodb_table" "terraform_lock" {
#   name           = "terraform-lock"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }