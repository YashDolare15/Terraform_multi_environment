variable "aws_region" {
  type        = string
  description = "The AWS region to deploy resources in"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "The environment for the resources (e.g., dev, prod)"
  default     = "dev"
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/26"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
  default     = "sarth-tf-vpc"
}

variable "public_subnet1_cidr" {
  type        = string
  description = "The CIDR block for the public subnet 1"
  default     = "10.0.0.0/27"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone for the public subnet"
  default     = "us-east-1a"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Whether to map public IP on launch for the public subnet"
  default     = true
}

variable "public_subnet1_name" {
  type        = string
  description = "The name of the public subnet 1"
  default     = "public-subnet-1"
}

variable "security_group_name" {
  type        = string
  description = "The name of the security group"
  default     = "sarth-terraform-sg"
}

variable "ssh_ingress_cidr" {
  type        = string
  description = "The CIDR block for SSH ingress"
  default     = "0.0.0.0/0"
}

variable "http_ingress_cidr" {
  type        = string
  description = "The CIDR block for HTTP ingress"
  default     = "0.0.0.0/0"
}

variable "https_ingress_cidr" {
  type        = string
  description = "The CIDR block for HTTPS ingress"
  default     = "0.0.0.0/0"
}

variable "rds_ingress_cidr" {
  type        = string
  description = "The CIDR block for RDS ingress"
  default     = "0.0.0.0/0"
}

variable "egress_cidr" {
  type        = string
  description = "The CIDR block for outbound traffic"
  default     = "0.0.0.0/0"
}

variable "instance_type" {
  type        = string
  description = "The instance type for the EC2 instance"
  default     = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "The name of the key pair to use for the EC2 instance"
  default     = "sarth_key"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Whether to associate a public IP address with the EC2 instance"
  default     = true
}

variable "instance_name" {
  type        = string
  description = "The name of the EC2 instance"
  default     = "sarth-terraform-instance"
}