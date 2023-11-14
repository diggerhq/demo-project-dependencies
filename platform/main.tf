terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.24.0"
    }
  }
    backend "s3" {
    bucket = "digger-s3backend-demo-project-dependencies"              # Change if a different S3 bucket name was used for the backend 
    key    = "terraform/state/digger-demo-platform"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

variable "subnet_id" {}

variable "sg_id" {}

resource "aws_instance" "platform_instance" {
  ami             = "ami-05c13eab67c5d8861"                   # us-east-1 Amazon Linux 2023 AMI 2023.2.20231030.1 x86_64 HVM kernel-6.1
  instance_type   = "t2.micro"
  subnet_id       = var.subnet_id
  security_groups = [var.sg_id]
  tags = {
    Name = "platform-instance"
  }
}
