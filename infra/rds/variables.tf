variable "vpc_id" {}
variable "ec2_sg_id" {}

variable "private_subnets" {
  description = "List of private subnet IDs for the RDS DB instance"
  type        = list(string)
}
