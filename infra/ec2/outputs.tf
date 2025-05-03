output "ec2_sg_id" {
  value = aws_security_group.backend_sg.id
}

output "ec2_instance_id" {
  value = aws_instance.backend_instance.id
}

output "backend_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.backend_instance.public_ip
}
