# opentofu-vpc

This is a Opentofu/Terraform module for creating AWS VPC using a standard
pattern:

* Two public subnets
* Two private subnets
    * IPv4 egress via NAT gateway (extra cost)
    * IPv6 egress via egress-only internet gateway

Example usage:

    module "acme-vpc" {
      source                              = <git-url>
      basename                            = "acme"
      region                              = "us-west-1"
      manage_ipv4_nat_gateway             = true
      vpc_cidr_block                      = "10.172.0.0/20"
      primary_public_subnet_cidr_block    = "10.172.0.0/24"
      secondary_public_subnet_cidr_block  = "10.172.1.0/24"
      primary_private_subnet_cidr_block   = "10.172.2.0/24"
      secondary_private_subnet_cidr_block = "10.172.3.0/24"
    }

See [input.tf](input.tf) for input variable documentation.
