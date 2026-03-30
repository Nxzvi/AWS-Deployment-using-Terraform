provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source          = "./module/vpc"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  vpc_name        = var.vpc_name
}

resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "nezvi-bucket"
    Environment = "dev"
  }
}

module "ec2" {
  source        = "./module/ec2"
  ami_id        = var.ami_id
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnets_ids[0]
  instance_type = var.instance_type
  key_name      = var.key_name

}

 