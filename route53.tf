resource "aws_route53_zone" "private_zone" {
  name = "wordpress"

  vpc {
    vpc_id = module.vpc.vpc_id
  }

  tags = local.common_tags
}