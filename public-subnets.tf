resource "aws_subnet" "primary_public" {
  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = var.primary_public_subnet_cidr_block
  ipv6_cidr_block                 = local.ipv6_cidrs[2]
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true
  availability_zone               = "${var.region}a"
  tags = {
    Name                  = "${var.basename}-primary-public"
  }
}

output "primary_public_subnet_id" {
  value = aws_subnet.primary_public.id
}

resource "aws_subnet" "secondary_public" {
  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = var.secondary_public_subnet_cidr_block
  ipv6_cidr_block                 = local.ipv6_cidrs[3]
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true
  availability_zone               = "${var.region}b"
  tags = {
    Name                  = "${var.basename}-secondary-public"
  }
}

output "secondary_public_subnet_id" {
  value = aws_subnet.secondary_public.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name                  = "${var.basename}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.basename}-public-subnets"
  }
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

resource "aws_route" "ipv4_egress_from_public_subnets_to_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "ipv6_egress_from_public_subnets_to_internet" {
  route_table_id              = aws_route_table.public.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "primary_public" {
  subnet_id      = aws_subnet.primary_public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "secondary_public" {
  subnet_id      = aws_subnet.secondary_public.id
  route_table_id = aws_route_table.public.id
}
