output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnet1_id" {
  value = aws_subnet.public_subnet1.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.my_igw.id
}

output "public_route_table_id" {
  value = aws_route_table.public_rt1.id
}