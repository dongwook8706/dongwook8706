locals {
  max_subnet_length = max(
    length(var.public_subnets),
    length(var.private_subnets),
    length(var.database_subnets),
#    length(var.redshift_subnets),
  )
  nat_gateway_count = var.single_nat_gateway ? 1 : var.one_nat_gateway_per_az ? length(var.azs) : local.max_subnet_length

  # Use `local.vpc_id` to give a hint to Terraform that subnets should be deleted before secondary CIDR blocks can be free!
#  vpc_id = try(aws_vpc_ipv4_cidr_block_association.this[0].vpc_id, aws_vpc.this[0].id, "")

  create_vpc = var.create_vpc 
}

################################################################################
# VPC
################################################################################

resource "aws_vpc" "ekstest" {
  count = local.create_vpc ? 1 : 0

  cidr_block                       = var.cidr
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
#  enable_classiclink               = var.enable_classiclink
#  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
#  assign_generated_ipv6_cidr_block = var.enable_ipv6

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.vpc_tags,
  )
}

