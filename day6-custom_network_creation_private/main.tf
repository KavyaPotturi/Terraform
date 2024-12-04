# Creation of "VPC"
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc"
  }
}

# Creation of "PUBLIC SUBNET"
resource "aws_subnet" "my_subnet_pub" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "subnet_pub"
  }
}

# Creation of "PRIVATE SUBNET"
resource "aws_subnet" "my_subnet_pvt" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "subnet_pvt"
  }
}

# Creation of "INTERNET GATEWAY"
resource "aws_internet_gateway" "my_ig" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "ig"
  }
}

# Creation of "ROUTE TABLE" and "EDIT ROUTES" for public routing
resource "aws_route_table" "my_rt_pub" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "rt_pub"
  }
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_ig.id
  }
}

# Creation of "SUBNET ASSOCIATION TO PUBLIC"
resource "aws_route_table_association" "association_pub" {
    route_table_id = aws_route_table.my_rt_pub.id
    subnet_id = aws_subnet.my_subnet_pub.id
}

# Creation of "EIP"
resource "aws_eip" "my_eip" {
  vpc = true
}

# Creation of "NAT GATEWAY"
resource "aws_nat_gateway" "my_nat" {
  subnet_id = aws_subnet.my_subnet_pub.id
  connectivity_type = "public"
  allocation_id = aws_eip.my_eip.id
  tags = {
    Name = "nat" 
  }
}

# Creation of "ROUTE TABLE" and "EDIT ROUTES" for private routing
resource "aws_route_table" "my_rt_pvt" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "rt_pvt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my_nat.id
  }
}

# Creation of "SUBNET ASSOCIATION" to private
resource "aws_route_table_association" "association_pvt" {
  route_table_id = aws_route_table.my_rt_pvt.id
  subnet_id = aws_subnet.my_subnet_pvt.id
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

# Creation of "PUBLIC Ec2 INSTANCE"
resource "aws_instance" "my_ec2_pub" {
  ami = "ami-0614680123427b75e"
  instance_type = "t2.micro"
  key_name = "AWS-key"
  subnet_id = aws_subnet.my_subnet_pub.id
  associate_public_ip_address = true
  security_groups = [ aws_security_group.my_sg.id ]
  tags = {
    Name = "Ec2_pub"
  }
}

# Creation of "PRIVATE Ec2 INSTANCE"
resource "aws_instance" "my_ec2_pvt" {
  ami = "ami-0614680123427b75e"
  instance_type = "t2.micro"
  key_name = "AWS-key"
  subnet_id = aws_subnet.my_subnet_pvt.id
  security_groups = [ aws_security_group.my_sg.id]
  tags = {
    Name = "Ec2_pvt"
  }
  
}