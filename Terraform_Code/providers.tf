terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Project     = "Multi-Environment-Terraform-Project"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}