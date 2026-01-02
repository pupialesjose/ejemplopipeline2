terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {}

resource "aws_instance" "demo" {
  ami           = "ami-0b9064170e32bde34" # Amazon Linux 2 us-east-2
  instance_type = "t2.micro"

  tags = {
    Name = "ec2-terraform-demo"
  }
}
