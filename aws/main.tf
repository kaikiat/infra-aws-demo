terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

locals {
  tags = {
    region  = "ap-southeast-1"
    keyname = "infra_aws_demo"
  }
}