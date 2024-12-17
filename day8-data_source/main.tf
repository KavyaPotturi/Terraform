data "aws_ami" "amzlinux" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}

data "aws_ec2_instance_type_offering" "example" {
  filter {
    name   = "instance-type"
    values = ["t2.micro"] # Specify the instance type you want to query
  }

  location_type = "region" # Filter instance types available in a region
}






resource "aws_instance" "dev" {
    ami = data.aws_ami.amzlinux.id
    instance_type = data.aws_ec2_instance_type_offering.example.id
    key_name = "AWS-key"
  
}