terraform {
  backend "s3" {
    bucket = "s3backendbucket-dynamodb"
    region = "ap-south-1"
    key = "terraform.tfstate"
    dynamodb_table = "terraform_state_lock_dynamodb"
    encrypt = true
  }
}