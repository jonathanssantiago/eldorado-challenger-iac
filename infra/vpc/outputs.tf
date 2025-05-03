
output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.eldorado_public_subnet.id
}

output "private_subnet_ids" {
  value = [
    aws_subnet.eldorado_private_subnet_a.id,
    aws_subnet.eldorado_private_subnet_b.id
  ]
}
