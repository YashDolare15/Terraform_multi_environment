variable "aws_region" {
  type        = string
  description = "The AWS region to deploy resources in"
}

variable "s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket for Terraform state"
}

variable "environment" {
  type        = string
  description = "The environment for the resources (e.g., dev, prod)"
}