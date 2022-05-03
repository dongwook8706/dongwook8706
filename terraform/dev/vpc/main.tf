locals {
  name   = "ekstest-dev-vpc"
  region = "ap-northeast-2"
  tags = {
    Name        = "ekstest-dev-vpc"
#    Owner       = "user"
#    Environment = "staging"
  }
}

################################################################################
# VPC setting
################################################################################

module "vpc" {
  source = "../../modules/vpc/"

  name = local.name
  cidr = "200.200.0.0/16"

  azs                 = ["${local.region}a", "${local.region}c"]
  public_subnets      = ["200.200.240.0/16", "200.200.240.128/16"]
  private_subnets     = ["200.200.10.0/16", "200.200.10.128/16"]
  database_subnets    = ["200.200.200.0/16", "200.200.200.128/16"]
#  database_subnets    = ["20.10.21.0/24", "20.10.22.0/24"]
#  elasticache_subnets = ["20.10.31.0/24", "20.10.32.0/24"]
#  redshift_subnets    = ["20.10.41.0/24", "20.10.42.0/24"]
#  intra_subnets       = ["20.10.51.0/24", "20.10.52.0/24"]

  create_database_subnet_group = false

  manage_default_network_acl = true
  default_network_acl_tags   = { Name = "${local.name}-default" }

  manage_default_route_table = true
  default_route_table_tags   = { Name = "${local.name}-default" }

  manage_default_security_group = true
  default_security_group_tags   = { Name = "${local.name}-default" }

  enable_dns_hostnames = true
  enable_dns_support   = true

#  enable_classiclink             = true
#  enable_classiclink_dns_support = true

  enable_nat_gateway = true
  single_nat_gateway = true

  customer_gateways = {
    IP1 = {
      bgp_asn     = 65112
      ip_address  = "1.2.3.4"
      device_name = "some_name"
    },
    IP2 = {
      bgp_asn    = 65112
      ip_address = "5.6.7.8"
    }
  }

  enable_vpn_gateway = true

  enable_dhcp_options              = true
  dhcp_options_domain_name         = "service.consul"
  dhcp_options_domain_name_servers = ["127.0.0.1", "10.10.0.2"]

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

  tags = local.tags
}

