output "public_ip" {
  description = "print public ip"
  value = aws_instance.ec2.public_ip
}