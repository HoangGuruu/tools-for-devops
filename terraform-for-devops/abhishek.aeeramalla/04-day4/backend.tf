# terraform {
#   backend "s3" {
#     bucket         = "terraform-20231006120843001000000001" # change this
#     key            = "guru/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-lock"
#   }
# }