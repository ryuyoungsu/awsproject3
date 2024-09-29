# VPC 생성
resource "aws_vpc" "ON-PREMISE-VPC" {
  cidr_block           = "10.240.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "ON-PREMISE-VPC"
  }
}