# opentofu-vpc

This is a Opentofu/Terraform module for creating AWS VPC using a standard
pattern:

* Two public subnets
* Two private subnets
    * IPv4 egress via NAT gateway (extra cost)
    * IPv6 egress via egress-only internet gateway

# Input variables

* **basename**: prefix or suffix to add to all resource names
* **region**: AWS region to create the VPC in
* **manage_ipv4_nat_gateway**: whether to create/manage the IPv4 NAT gateway for extra cost (boolean, defaults to false)
* **vpc_cidr_block**: CIDR block for the VPC
* **primary_public_subnet_cidr_block**: CIDR block for the primary public subnet
* **secondary_public_subnet_cidr_block**: CIDR block for the secondary public subnet
* **primary_private_subnet_cidr_block**: CIDR block for the primary private subnet
* **secondary_private_subnet_cidr_block**: CIDR block for the secondary private subnet

# Output variables

* **primary_private_subnet_id**: ID of the primary private subnet
* **secondary_private_subnet_id**: ID of the secondary private subnet
* **private_route_table_id**: ID of the private subnet routing table
* **primary_public_subnet_id**: ID of the primary public subnet
* **secondary_public_subnet_id**: ID of the secondary public subnet
* **public_route_table_id**: ID of the public subnet routing table
* **vpc_id**: the ID of the VPC
* **cidr_block**: the CIDR block of the VPC

# Example usage

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
