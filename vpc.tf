resource "aws_vpc" "vpc" {
  cidr_block                       = var.vpc_cidr_block
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name                  = "${var.basename}-vpc"
  }
}
output "vpc_id" {
  value = aws_vpc.vpc.id
}
