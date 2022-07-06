locals {
  ipv6_cidrs = cidrsubnets(aws_vpc.vpc.ipv6_cidr_block, 8, 8, 8, 8)
}
