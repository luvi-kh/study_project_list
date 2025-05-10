terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-northeast-2"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "fast-vpc"
  cidr = "10.0.0.0/16"

  azs            = ["ap-northeast-2a"]
  public_subnets = ["10.0.1.0/24"]
  
  default_security_group_ingress = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-091aca13f89c7964e"
  instance_type = "t3.nano"
  subnet_id     = "${module.vpc.public_subnets[0]}"
  associate_public_ip_address = true

  tags = {
    Name = "Terraform Demo Server"
  }
}
