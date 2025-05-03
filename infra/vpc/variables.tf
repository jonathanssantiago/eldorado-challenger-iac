variable "aws_region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
}

variable "environment" {
  description = "Ambiente"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR da subnet pública"
  type        = string
}

variable "private_subnet_a_cidr" {
  description = "CIDR da subnet privada A"
  type        = string
}

variable "private_subnet_b_cidr" {
  description = "CIDR da subnet privada B"
  type        = string
}
