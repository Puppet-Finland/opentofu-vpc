output "primary_private_subnet_id" {
  value = aws_subnet.primary_private.id
}

output "secondary_private_subnet_id" {
  value = aws_subnet.secondary_private.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}

output "primary_public_subnet_id" {
  value = aws_subnet.primary_public.id
}

output "secondary_public_subnet_id" {
  value = aws_subnet.secondary_public.id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}
