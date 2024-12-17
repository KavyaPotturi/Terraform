variable "port_source_map" {
  default = {
    22   = ["192.168.1.0/24"]    # SSH allowed from internal network
    80   = ["0.0.0.0/0"]         # HTTP open to all
    443  = ["0.0.0.0/0"]         # HTTPS open to all
    8080 = ["203.0.113.0/24"]    # Custom app port restricted
    9000 = ["10.0.0.0/16"]       # Monitoring port restricted
  }
}

resource "aws_security_group" "example" {
  name = "example-sg"

  ingress = [
    for port, sources in var.port_source_map : {
      description      = "inbound rule for port ${port}"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = sources
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
}



resource "aws_instance" "forloop" {
  ami                    = "ami-0fd05997b4dff7aac"      #change ami id for different region
  instance_type          = "t2.micro"
  key_name               = "AWS-key"              #change key name as per your setup
 
  tags = {
    Name = "forloop-ec2"
  }
}  