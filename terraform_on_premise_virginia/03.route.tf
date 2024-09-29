resource "aws_route" "ON-PREMISE-RT-PUB" {
  route_table_id         = aws_route_table.ON-PREMISE-RT-PUB.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ON-PREMISE-IGW.id

}

resource "aws_route" "ON-PREMISE-PRD-RT-PRI" {
  route_table_id         = aws_route_table.ON-PREMISE-RT-PRI.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ON-PREMISE-NGW.id
}
