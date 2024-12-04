output "instance_public_ip" {
  value = aws_instance.ec2.public_ip
  sensitive = true
}

output "instance_id" {
  value = aws_instance.ec2.id
}