output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet1_id" {
  value = module.vpc.public_subnet1_id
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "public_route_table_id" {
  value = module.vpc.public_route_table_id
}

output "security_group_id" {
  value = module.security_groups.security_group_id
}

output "security_group_name" {
  value = module.security_groups.security_group_name
}

output "ec2_instance_id" {
  value = module.ec2_instance.instance_id
}

output "ec2_instance_public_ip" {
  value = module.ec2_instance.instance_public_ip
}

output "ec2_instance_key_name" {
  value = module.ec2_instance.instance_key_name
}
