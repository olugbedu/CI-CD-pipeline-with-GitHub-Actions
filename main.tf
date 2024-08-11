provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source           = "./modules/vpc"
  vpc_cidr         = "10.0.0.0/16"
  vpc_name         = "deji-vpc"
  availability_zone = "eu-west-1a"
}

module "ec2" {
  source         = "./modules/ec2"
  ami            = "ami-0c38b837cd80f13bb"  # Ubuntu Server 24.04 LTS (HVM)
  instance_type  = "t2.medium"
  subnet_id      = module.vpc.subnet
  vpc_id         = module.vpc.vpc_id
  key_name       = "MyFirstKeyPair"
}
