output "rds_endpoint" {
  value       = module.rds.rds_eldorado_endpoint
  description = "Endpoint do banco de dados RDS"
  sensitive   = false
}

output "ec2_public_dns" {
  value       = module.ec2.ec2_public_dns
  description = "DNS público da instância EC2"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "ID da VPC criada"
}

output "public_subnet_id" {
  value       = module.vpc.public_subnet_id
  description = "ID da subnet pública"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "IDs das subnets privadas"
}
