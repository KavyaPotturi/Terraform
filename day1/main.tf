resource "aws_instance" "name" {
    ami = "ami-0614680123427b75e"
    instance_type = "t2.micro"
    key_name = "AWS-key"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "ec2"
    }
}