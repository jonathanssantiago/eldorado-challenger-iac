# Configurações gerais
aws_region  = "us-east-1"
environment = "prod"

# VPC
vpc_cidr              = "10.0.0.0/16"
public_subnet_cidr    = "10.0.1.0/24"
private_subnet_a_cidr = "10.0.2.0/24"
private_subnet_b_cidr = "10.0.3.0/24"

# EC2
ami_id          = "ami-0f9de6e2d2f067fca"
instance_type   = "t3.micro"
public_key_path = "~/.ssh/id_rsa.pub"

# RDS
db_name           = "eldorado_challenge"
db_username       = "eldorado_user"
db_password       = "eldorado_password"
db_instance_class = "db.t3.micro"
