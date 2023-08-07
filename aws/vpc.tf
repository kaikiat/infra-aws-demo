resource "aws_vpc" "gt_vpc" {
  cidr_block           = "10.1.64.0/18"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "gt_subnet_1" {
  vpc_id                  = aws_vpc.gt_vpc.id
  cidr_block              = "10.1.64.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"
}

resource "aws_subnet" "gt_subnet_2" {
  vpc_id                  = aws_vpc.gt_vpc.id
  cidr_block              = "10.1.65.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1b"
}

