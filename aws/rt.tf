resource "aws_route_table" "gt_route_table" {
  vpc_id = aws_vpc.gt_vpc.id
}

resource "aws_route" "tm_route" {
  route_table_id         = aws_route_table.tm_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tm_igw.id
}

resource "aws_route_table_association" "gt_rta_1" {
  subnet_id      = aws_subnet.gt_subnet.id
  route_table_id = aws_route_table.gt_route_table.id
}

resource "aws_route_table_association" "gt_rta_2" {
  subnet_id      = aws_subnet.gt_subnet.id
  route_table_id = aws_route_table.gt_route_table.id
}