module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  // azs
  azs = ["${local.region}a", "${local.region}b", "${local.region}c"]

  // subnets
  public_subnets   = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k)]
  private_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 4)]
  database_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 8)]

  // database
  create_database_subnet_group       = true
  create_database_subnet_route_table = true

  // nat gateway
  enable_nat_gateway = true
  single_nat_gateway = true

  // vpc settings
  default_vpc_enable_dns_hostnames = true
  map_public_ip_on_launch          = true

  // tagging
  public_subnet_tags = {
    Type = "${var.vpc_name}-public-subnets"
  }

  private_subnet_tags = {
    Type = "${var.vpc_name}-private-subnets"
  }

  database_subnet_tags = {
    Type = "${var.vpc_name}-database-subnets"
  }

  vpc_tags = merge(local.common_tags, {
    Name = var.vpc_name
  })

}