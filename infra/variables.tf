variable "aws_region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Ambiente"
  type        = string
  default     = "prod"
}

# VPC Variables
variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR da subnet pública"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_a_cidr" {
  description = "CIDR da subnet privada A"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_b_cidr" {
  description = "CIDR da subnet privada B"
  type        = string
  default     = "10.0.3.0/24"
}

# EC2 Variables
variable "ami_id" {
  description = "ID da AMI para instância EC2"
  type        = string
  default     = "ami-0f9de6e2d2f067fca"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "public_key_path" {
  description = "Caminho para arquivo de chave pública SSH"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

# RDS Variables
variable "db_name" {
  description = "Nome do banco de dados RDS"
  type        = string
  default     = "eldorado"
}

variable "db_username" {
  description = "Nome de usuário para o banco de dados RDS"
  type        = string
  default     = "eldorado_user"
  sensitive   = true
}

variable "db_password" {
  description = "Senha para o banco de dados RDS"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "Classe da instância do RDS"
  type        = string
  default     = "db.t3.micro"
}

# S3 Variables
variable "bucket_name" {
  type        = string
  description = "Nome do bucket S3"
  default     = "device-management-frontend-bucket"
}

variable "domain_name" {
  description = "Domínio"
  type        = string
  default     = ""
}

