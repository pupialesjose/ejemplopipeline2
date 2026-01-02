terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "pipeline-demo-${random_id.suffix.hex}"

  tags = {
    Name        = "PipelineDemo"
    Environment = "Dev"
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}

variable "aws_region" {
  default = "us-east-1"
}

output "bucket_name" {
  value = aws_s3_bucket.demo_bucket.bucket
}
