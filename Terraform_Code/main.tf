module "vpc" {
  source                  = "./modules/vpc"
  cidr_block              = var.cidr_block
  vpc_name                = var.vpc_name
  public_subnet1_cidr     = var.public_subnet1_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch
  public_subnet1_name     = var.public_subnet1_name
}

module "security_groups" {
  source              = "./modules/security_groups"
  security_group_name = var.security_group_name
  vpc_id              = module.vpc.vpc_id
  ssh_ingress_cidr    = var.ssh_ingress_cidr
  http_ingress_cidr   = var.http_ingress_cidr
  https_ingress_cidr  = var.https_ingress_cidr
  rds_ingress_cidr    = var.rds_ingress_cidr
  egress_cidr         = var.egress_cidr
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

module "ec2_instance" {
  source                      = "./modules/ec2"
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  vpc_security_group_id       = module.security_groups.security_group_id
  subnet_id                   = module.vpc.public_subnet1_id
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  instance_name               = var.instance_name
}