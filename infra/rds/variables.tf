variable "aws_region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
}

variable "environment" {
  description = "Ambiente"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "private_subnets" {
  description = "Lista de IDs de subnets privadas"
  type        = list(string)
}

variable "ec2_sg_id" {
  description = "ID do grupo de segurança da instância EC2"
  type        = string
}

variable "db_name" {
  description = "Nome do banco de dados RDS"
  type        = string
}

variable "db_username" {
  description = "Nome de usuário para o banco de dados RDS"
  type        = string
}

variable "db_password" {
  description = "Senha para o banco de dados RDS"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "Classe da instância do RDS"
  type        = string
}
