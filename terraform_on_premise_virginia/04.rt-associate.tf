resource "aws_route_table_association" "ON-PREMISE-RT-ASSOCIATE-PUB-BASTION-2A" {
  subnet_id      = aws_subnet.ON-PREMISE-PUB-1A.id
  route_table_id = aws_route_table.ON-PREMISE-RT-PUB.id
}

resource "aws_route_table_association" "ON-PREMISE-RT-ASSOCIATE-PRI-2A" {
  subnet_id      = aws_subnet.ON-PREMISE-PRI-1A.id
  route_table_id = aws_route_table.ON-PREMISE-RT-PRI.id
}