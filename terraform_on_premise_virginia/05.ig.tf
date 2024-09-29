resource "aws_internet_gateway" "ON-PREMISE-IGW" {
  vpc_id = aws_vpc.ON-PREMISE-VPC.id
  tags = {
    "Name" = "ON-PREMISE-IGW"
  }
}