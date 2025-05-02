# variables.tf

variable "bucket_name" {
  type = string
  description = "Nome do bucket S3"
  default     = "device-management-frontend-bucket"
}
