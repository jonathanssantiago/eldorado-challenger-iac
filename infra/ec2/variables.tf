variable "aws_region" {
  default = "us-east-1"
}
variable "ami_id" {
  default = "ami-0f9de6e2d2f067fca"
}
variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_id" {}
variable "public_subnet" {}
