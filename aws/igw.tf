resource "aws_internet_gateway" "gt_igw" {
  vpc_id = aws_vpc.gt_vpc.id
}