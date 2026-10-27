variable "ami" {
  type        = string
  description = "The AMI ID for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "The instance type for the EC2 instance"
}

variable "vpc_security_group_id" {
  type        = string
  description = "The ID of the security group to associate with the EC2 instance"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet to launch the EC2 instance in"
}

variable "key_name" {
  type        = string
  description = "The name of the key pair to use for the EC2 instance"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Whether to associate a public IP address with the EC2 instance"
}

variable "instance_name" {
  type        = string
  description = "The name tag for the EC2 instance"
}