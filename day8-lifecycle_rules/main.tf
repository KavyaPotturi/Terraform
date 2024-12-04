resource "aws_instance" "name" {
  ami = "ami-0614680123427b75e"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "Ec2"
  }


    #lifecycle {
    #create_before_destroy = true
    #}

    #lifecycle{
    #prevent_destroy = true
    #}

    #lifecycle{
    #ignore_changes = [tags, ]
    #}
}