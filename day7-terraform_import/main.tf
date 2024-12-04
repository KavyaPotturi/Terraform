resource "aws_instance" "ec2" {
    ami = "ami-0614680123427b75e"
    instance_type = "t2.micro"
    key_name = "AWS-key"
    tags = {
      Name = "ec2"
    }
}

resource "aws_s3_bucket" "test" {
  bucket = "mys3bucketimport"
}