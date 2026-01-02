terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {}

# VPC
resource "aws_vpc" "demo" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-terraform-demo"
  }
}

# Subnet pública
resource "aws_subnet" "demo" {
  vpc_id                  = aws_vpc.demo.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-terraform-demo"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = "igw-terraform-demo"
  }
}

# Route Table
resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo.id
  }

  tags = {
    Name = "rt-terraform-demo"
  }
}

# Asociación
resource "aws_route_table_association" "demo" {
  subnet_id      = aws_subnet.demo.id
  route_table_id = aws_route_table.demo.id
}

# EC2
resource "aws_instance" "demo" {
  ami                    = "ami-0b9064170e32bde34"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.demo.id
  associate_public_ip_address = true

  tags = {
    Name = "ec2-terraform-demo"
  }
}
