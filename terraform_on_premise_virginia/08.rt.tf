resource "aws_route_table" "ON-PREMISE-RT-PUB" {
  vpc_id = aws_vpc.ON-PREMISE-VPC.id
  tags = {
    "Name" = "ON-PREMISE-RT-PUB"
  }

}

resource "aws_route_table" "ON-PREMISE-RT-PRI" {
  vpc_id = aws_vpc.ON-PREMISE-VPC.id
  tags = {
    "Name" = "ON-PREMISE-RT-PRI"
  }
}