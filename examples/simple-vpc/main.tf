provider "aws" {
  region = local.region
}

locals {
  region = "ap-southeast-1"
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "../../"

  name = "test-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_ipv6 = false 

  enable_nat_gateway = false
  single_nat_gateway = true

  public_subnet_tags = {
    Name = "public-subnet"
  }

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "dev-test"
  }
}
