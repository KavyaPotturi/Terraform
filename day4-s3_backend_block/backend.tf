terraform {
  backend "s3" {
    bucket = "mys3bucketbackend"
    region = "ap-south-1"
    key = "day4-s3_backend_block/terraform.tfstate"
    encrypt = true
  }
}