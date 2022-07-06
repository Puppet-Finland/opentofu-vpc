variable "basename" {
  description = "Prefix or suffix to add to all resource names"
  type        = string
}

variable "region" {
  description = "AWS region to create the VPC in"
  type        = string
}

variable "manage_ipv4_nat_gateway" {
  description = "Whether to create/manage the IPv4 NAT gateway (extra cost)"
  type        = bool
  default     = false
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "primary_public_subnet_cidr_block" {
  description = "CIDR block for the primary public subnet"
  type        = string
}

variable "secondary_public_subnet_cidr_block" {
  description = "CIDR block for the secondary public subnet"
  type        = string

}

variable "primary_private_subnet_cidr_block" {
  description = "CIDR block for the primary private subnet"
  type        = string
}

variable "secondary_private_subnet_cidr_block" {
  description = "CIDR block for the secondary private subnet"
  type        = string
}
