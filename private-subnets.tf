resource "aws_subnet" "primary_private" {
  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = var.primary_private_subnet_cidr_block
  ipv6_cidr_block                 = local.ipv6_cidrs[0]
  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = true
  availability_zone               = "${var.region}a"
  tags = {
    Name                  = "${var.basename}-primary-private"
  }
}

resource "aws_subnet" "secondary_private" {
  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = var.secondary_private_subnet_cidr_block
  ipv6_cidr_block                 = local.ipv6_cidrs[1]
  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = true
  availability_zone               = "${var.region}b"
  tags = {
    Name                  = "${var.basename}-secondary-private"
  }
}

resource "aws_eip" "ngw" {
  count      = var.manage_ipv4_nat_gateway ? 1 : 0
  vpc        = true
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name                  = "${var.basename}-ngw-eip"
  }
}

resource "aws_nat_gateway" "default" {
  count         = var.manage_ipv4_nat_gateway ? 1 : 0
  allocation_id = aws_eip.ngw[0].id
  subnet_id     = aws_subnet.primary_public.id

  tags = {
    Name                  = "${var.basename}-nat-gateway"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_egress_only_internet_gateway" "default" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name                  = "${var.basename}-egress-only-internet-gateway"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.basename}-private-subnets"
  }
}

resource "aws_route" "ipv4_egress_from_private_subnets_to_internet" {
  count                  = var.manage_ipv4_nat_gateway ? 1 : 0
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.default[0].id
}

resource "aws_route" "ipv6_egress_from_private_subnets_to_internet" {
  route_table_id              = aws_route_table.private.id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.default.id
}

resource "aws_route_table_association" "primary_private" {
  subnet_id      = aws_subnet.primary_private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "secondary_private" {
  subnet_id      = aws_subnet.secondary_private.id
  route_table_id = aws_route_table.private.id
}
