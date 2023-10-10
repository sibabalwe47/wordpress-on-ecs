locals {
  # availability zones
  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  # common tags
  common_tags = {
    ConfigManagement = "terraform"
    Environment      = "dev"
    ProjectName      = "wordpress"
  }

  # region
  region = data.aws_region.current.name
}