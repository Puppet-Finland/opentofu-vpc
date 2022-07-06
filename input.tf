# Base name for names, tags, etc.
variable "basename" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "primary_public_subnet_cidr_block" {
  type = string
}

variable "secondary_public_subnet_cidr_block" {
  type = string
}

variable "primary_private_subnet_cidr_block" {
  type = string
}

variable "secondary_private_subnet_cidr_block" {
  type = string
}
