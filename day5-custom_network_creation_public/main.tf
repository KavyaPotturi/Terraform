# Creation of "VPC"
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc"
  }
}

# Creation of "SUBNET"
resource "aws_subnet" "my_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  availability_zone = "ap-south-1b"
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "subnet"
  }
}

# Creation of "INTERNET GATEWAY"
resource "aws_internet_gateway" "my_ig" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "ig"
  }
}

# Creation of "ROUTE TABLE" and "EDIT ROUTES"
resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "rt"
  }
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_ig.id
  }
}

# Creation of "SUBNET ASSOCIATION TO PUBLIC"
resource "aws_route_table_association" "association" {
    route_table_id = aws_route_table.my_rt.id
    subnet_id = aws_subnet.my_subnet.id
}

# Creation of "SECURITY GROUP"
resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "sg"
  }
  ingress {
    description = "allow ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

# Creation of "Ec2 INSTANCE"
resource "aws_instance" "my_ec2" {
  ami = "ami-0614680123427b75e"
  instance_type = "t2.micro"
  key_name = "AWS-key"
  associate_public_ip_address = true
  subnet_id = aws_subnet.my_subnet.id
  security_groups = [ aws_security_group.my_sg.id ]
  tags = {
    Name = "Ec2"
  }
}