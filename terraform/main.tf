terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "ecommerce-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-1a", "us-west-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
  default_security_group_ingress = [{ "protocol" : "-1", "self" : true }]
  default_security_group_egress  = [{ "protocol" : "-1", "cidr_blocks" : "0.0.0.0/0" }]
}
