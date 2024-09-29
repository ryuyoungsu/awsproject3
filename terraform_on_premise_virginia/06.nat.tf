resource "aws_eip" "ON-PREMISE-EIP" {
  domain = "vpc"
}

resource "aws_eip" "ON-PREMISE-EIP-02" {
  domain = "vpc"  
}

resource "aws_nat_gateway" "ON-PREMISE-NGW" {
  allocation_id = aws_eip.ON-PREMISE-EIP.id
  subnet_id     = aws_subnet.ON-PREMISE-PUB-1A.id
  tags = {
    "Name" = "ON-PREMISE-NGW"
  }
}

# Openswan 설치한 EC2 Instance와 동일한 IP
resource "aws_eip_association" "eip_association" {
  instance_id   = aws_instance.ON-PREMISE-PUB-VPN-MANAGED-SERVER-1A.id
  allocation_id = aws_eip.ON-PREMISE-EIP-02.id
}
