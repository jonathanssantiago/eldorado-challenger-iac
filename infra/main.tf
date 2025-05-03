provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source        = "./ec2"
  vpc_id        = module.vpc.vpc_id
  public_subnet = module.vpc.public_subnet_id
}

module "rds" {
  source          = "./rds"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnet_ids
  ec2_sg_id       = module.ec2.ec2_sg_id
}
