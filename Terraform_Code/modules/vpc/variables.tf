variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
}

variable "public_subnet1_cidr" {
  type        = string
  description = "The CIDR block for the public subnet 1"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone for the public subnet"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Whether to map public IP on launch for the public subnet"
}

variable "public_subnet1_name" {
  type        = string
  description = "The name of the public subnet 1"
}
