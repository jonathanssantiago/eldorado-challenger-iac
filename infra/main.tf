terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "eldorado-challenge"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

module "vpc" {
  source = "./vpc"

  aws_region            = var.aws_region
  environment           = var.environment
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidr    = var.public_subnet_cidr
  private_subnet_a_cidr = var.private_subnet_a_cidr
  private_subnet_b_cidr = var.private_subnet_b_cidr
}

module "ec2" {
  source = "./ec2"

  aws_region      = var.aws_region
  environment     = var.environment
  vpc_id          = module.vpc.vpc_id
  public_subnet   = module.vpc.public_subnet_id
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  public_key_path = var.public_key_path
}

module "rds" {
  source = "./rds"

  aws_region      = var.aws_region
  environment     = var.environment
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnet_ids
  ec2_sg_id       = module.ec2.ec2_sg_id

  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  db_instance_class = var.db_instance_class
}

module "s3" {
  source = "./s3-bucket-static"

  aws_region  = var.aws_region
  environment = var.environment
  bucket_name = var.bucket_name
  domain_name = var.domain_name
}
