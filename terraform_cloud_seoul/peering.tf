# VPC Peering 연결
/*resource "aws_vpc_peering_connection" "prd_dev_peering" {
  vpc_id      = aws_vpc.PRD-VPC.id
  peer_vpc_id = aws_vpc.DEV-VPC.id
  auto_accept = true    # 자동으로 Peering 연결을 승인

  tags = {
    "Name" = "PRD-DEV-Peering"
  }
}

# Peering 연결에 대한 라우팅 설정 (PRD-VPC에서 DEV-VPC로 라우팅)
resource "aws_route" "PRD_to_DEV_route" {
  route_table_id            = aws_vpc.PRD-VPC.main_route_table_id
  destination_cidr_block    = aws_vpc.DEV-VPC.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.prd_dev_peering.id
}

# Peering 연결에 대한 라우팅 설정 (DEV-VPC에서 PRD-VPC로 라우팅)
resource "aws_route" "DEV_to_PRD_route" {
  route_table_id            = aws_vpc.DEV-VPC.main_route_table_id
  destination_cidr_block    = aws_vpc.PRD-VPC.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.prd_dev_peering.id
}*/