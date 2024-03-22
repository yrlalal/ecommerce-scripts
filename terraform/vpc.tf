module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "ecommerce-vpc"
  cidr = var.cidr

  azs             = var.aws_zones
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