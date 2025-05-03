variable "aws_region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
}

variable "environment" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "public_subnet" {
  description = "ID da subnet pública"
  type        = string
}

variable "ami_id" {
  description = "ID da AMI para instância EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
}

variable "public_key_path" {
  description = "Caminho para arquivo de chave pública SSH"
  type        = string
}
