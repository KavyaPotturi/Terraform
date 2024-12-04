# Datasource for subnet id
data "aws_subnet" "subnet_id" {
  filter {
    name = "tag:Name"
    values = [ "subnet" ]
  }
}

# Datasource for ami id
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

resource "aws_instance" "Ec2" {
  ami = data.aws_ami.amzlinux.id
  instance_type = "t2.micro"
  key_name = "AWS-key"
  subnet_id = data.aws_subnet.subnet_id.id
}