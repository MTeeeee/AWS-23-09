terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = "eu-central-1"
  profile                  = "techstarter"
  shared_credentials_files = ["credentials.txt"]
}

module "create_vpc" {
  source = "./modules/vpc"
  project_name = "${var.env}-${var.project_name}"
  vpc_cidr = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
}

module "create_ec2" {
  source = "./modules/ec2"
  project_name = var.project_name
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = module.create_vpc.subnet_id
  vpc_id = module.create_vpc.vpc_id
  key_name = aws_key_pair.deployer.id
}