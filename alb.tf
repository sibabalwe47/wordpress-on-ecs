module "alb" {
  depends_on = [module.vpc]
  source     = "terraform-aws-modules/alb/aws"
  version    = "~> 8.0"

  name                = local.common_tags.ProjectName
  load_balancer_type  = "application"
  internal            = false
  vpc_id              = module.vpc.vpc_id
  subnets             = module.vpc.public_subnets
  security_group_name = "${local.common_tags.ProjectName}-sg"
  security_group_rules = {
    ingress_all_http = {
      type        = "ingress"
      description = "Allow all HTTP traffic."
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    ingress_all_https = {
      type        = "ingress"
      description = "Allow all HTTPS traffic."
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = local.common_tags
}
