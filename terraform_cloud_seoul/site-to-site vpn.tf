# terraform code 파일
/*resource "aws_eip" "PRD-EIP-03" {
  domain = "vpc"
}

# 가상 프라이빗 게이트웨이 생성
resource "aws_vpn_gateway" "prd_vpn_gateway" {
  vpc_id = aws_vpc.PRD-VPC.id

  tags = {
    Name = "prd_vpn_gateway"
  }
}

# 고객 게이트웨이 생성
resource "aws_customer_gateway" "prd_customer_gateway" {
  bgp_asn    = 65000
  ip_address = aws_eip.PRD-EIP-03.public_ip # 고객측 공인 IP 입력
  type       = "ipsec.1"

  tags = {
    Name = "prd_customer_gateway"
  }
}

# VPN 연결 생성
resource "aws_vpn_connection" "seoul_us_vpn_connection" {
  vpn_gateway_id      = aws_vpn_gateway.prd_vpn_gateway.id
  customer_gateway_id = aws_customer_gateway.prd_customer_gateway.id
  type                = "ipsec.1"

  static_routes_only = true

  tags = {
    Name = "seoulus_vpn_connection"
  }
}

# VPN 연결의 라우팅 설정
resource "aws_vpn_connection_route" "seoul_us_vpn_route" {
  vpn_connection_id      = aws_vpn_connection.seoul_us_vpn_connection.id
  destination_cidr_block = "10.240.0.0/16" # 버지니아 VPC의 CIDR

}*/
