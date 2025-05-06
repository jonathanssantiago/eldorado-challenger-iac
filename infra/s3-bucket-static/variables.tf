variable "aws_region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
}

variable "environment" {
  description = "Ambiente"
  type        = string
}
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

variable "use_cloudfront" {
  description = "Se deve usar CloudFront ou não"
  type        = bool
  default     = true
}
