# PRD SG
# BASTION SG
resource "aws_security_group" "PRD-SG-BASTION" {
  name        = "PRD-SG-BASTION"
  description = "for bastion Server"
  vpc_id      = aws_vpc.PRD-VPC.id
  tags = {
    "Name" = "PRD-SG-BASTION"
  }
}

resource "aws_security_group_rule" "PRD-SG-BASTION-INGRESS-SSH" {
  security_group_id = aws_security_group.PRD-SG-BASTION.id
  type              = "ingress"
  description       = "allow all for ssh"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "PRD-SG-BASTION-EGRESS" {
  security_group_id = aws_security_group.PRD-SG-BASTION.id
  type              = "egress"
  description       = "allow all for all outbound"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# EKS-MANAGED-SERVER SG
resource "aws_security_group" "PRD-SG-EKS-MANAGED-SERVER" {
  name        = "PRD-SG-EKS-MANAGED-SERVER"
  description = "for eks-managed Server"
  vpc_id      = aws_vpc.PRD-VPC.id
  tags = {
    "Name" = "PRD-SG-EKS-MANAGED-SERVER"
  }
}

resource "aws_security_group_rule" "PRD-SG-EKS-MANAGED-SERVER-SSH" {
  security_group_id = aws_security_group.PRD-SG-EKS-MANAGED-SERVER.id
  type              = "ingress"
  description       = "allow all for ssh"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "PRD-SG-EKS-MANAGED-SERVER-INGRESS-HTTP" {
  security_group_id = aws_security_group.PRD-SG-EKS-MANAGED-SERVER.id
  type              = "ingress"
  description       = "allow all for http"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "PRD-SG-EKS-MANAGED-SERVER-INGRESS-HTTPS" {
  security_group_id = aws_security_group.PRD-SG-EKS-MANAGED-SERVER.id
  type              = "ingress"
  description       = "allow all for https"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "PRD-SG-EKS-MANAGED-SERVER-EGRESS" {
  security_group_id = aws_security_group.PRD-SG-EKS-MANAGED-SERVER.id
  type              = "egress"
  description       = "allow all for all outbound"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# EFS-MANAGED-SERVER SG
resource "aws_security_group" "PRD-SG-EFS-MANAGED-SERVER" {
  name        = "PRD-SG-EFS-MANAGED-SERVER"
  description = "for efs-managed Server"
  vpc_id      = aws_vpc.PRD-VPC.id
  tags = {
    "Name" = "PRD-SG-EFS-MANAGED-SERVER"
  }
}

resource "aws_security_group_rule" "PRD-SG-EFS-MANAGED-SERVER-INGRESS-SSH" {
  security_group_id = aws_security_group.PRD-SG-EFS-MANAGED-SERVER.id
  type              = "ingress"
  description       = "allow all for ssh"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "PRD-SG-EFS-MANAGED-SERVER-INGRESS-EFS" {
  security_group_id = aws_security_group.PRD-SG-EFS-MANAGED-SERVER.id
  type              = "ingress"
  description       = "allow all for efs"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "PRD-SG-EFS-MANAGED-SERVER-EGRESS" {
  security_group_id = aws_security_group.PRD-SG-EFS-MANAGED-SERVER.id
  type              = "egress"
  description       = "allow all for all outbound"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# RDS SG
resource "aws_security_group" "PRD-SG-RDS" {
  name   = "for rds"
  vpc_id = aws_vpc.PRD-VPC.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Redis SG
resource "aws_security_group" "PRD-SG-REDIS" {
  name   = "for redis"
  vpc_id = aws_vpc.PRD-VPC.id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# DEV SG
# BASTION SG
/*resource "aws_security_group" "DEV-SG-BASTION" {
  name        = "DEV-SG-BASTION"
  description = "for bastion Server"
  vpc_id      = aws_vpc.DEV-VPC.id
  tags = {
    "Name" = "DEV-SG-BASTION"
  }
}

resource "aws_security_group_rule" "DEV-SG-BASTION-INGRESS-SSH" {
  security_group_id = aws_security_group.DEV-SG-BASTION.id
  type              = "ingress"
  description       = "allow all for ssh"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "DEV-SG-BASTION-EGRESS" {
  security_group_id = aws_security_group.DEV-SG-BASTION.id
  type              = "egress"
  description       = "allow all for all outbound"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# EKS-MANAGED-SERVER SG
resource "aws_security_group" "DEV-SG-EKS-MANAGED-SERVER" {
  name        = "DEV-SG-EKS-MANAGED-SERVER"
  description = "for eks-managed Server"
  vpc_id      = aws_vpc.DEV-VPC.id
  tags = {
    "Name" = "DEV-SG-EKS-MANAGED-SERVER"
  }
}

resource "aws_security_group_rule" "DEV-SG-EKS-MANAGED-SERVER-SSH" {
  security_group_id = aws_security_group.DEV-SG-EKS-MANAGED-SERVER.id
  type              = "ingress"
  description       = "allow all for ssh"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "DEV-SG-EKS-MANAGED-SERVER-INGRESS-HTTP" {
  security_group_id = aws_security_group.DEV-SG-EKS-MANAGED-SERVER.id
  type              = "ingress"
  description       = "allow all for http"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "DEV-SG-EKS-MANAGED-SERVER-INGRESS-HTTPS" {
  security_group_id = aws_security_group.DEV-SG-EKS-MANAGED-SERVER.id
  type              = "ingress"
  description       = "allow all for https"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "DEV-SG-EKS-MANAGED-SERVER-EGRESS" {
  security_group_id = aws_security_group.DEV-SG-EKS-MANAGED-SERVER.id
  type              = "egress"
  description       = "allow all for all outbound"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# EFS-MANAGED-SERVER SG
resource "aws_security_group" "DEV-SG-EFS-MANAGED-SERVER" {
  name        = "DEV-SG-EFS-MANAGED-SERVER"
  description = "for efs-managed Server"
  vpc_id      = aws_vpc.DEV-VPC.id
  tags = {
    "Name" = "DEV-SG-EFS-MANAGED-SERVER"
  }
}

resource "aws_security_group_rule" "DEV-SG-EFS-MANAGED-SERVER-INGRESS-SSH" {
  security_group_id = aws_security_group.DEV-SG-EFS-MANAGED-SERVER.id
  type              = "ingress"
  description       = "allow all for ssh"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "DEV-SG-EFS-MANAGED-SERVER-INGRESS-EFS" {
  security_group_id = aws_security_group.DEV-SG-EFS-MANAGED-SERVER.id
  type              = "ingress"
  description       = "allow all for efs"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "DEV-SG-EFS-MANAGED-SERVER-EGRESS" {
  security_group_id = aws_security_group.DEV-SG-EFS-MANAGED-SERVER.id
  type              = "egress"
  description       = "allow all for all outbound"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# RDS SG
resource "aws_security_group" "DEV-SG-RDS" {
  name   = "for rds"
  vpc_id = aws_vpc.DEV-VPC.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Redis SG
resource "aws_security_group" "DEV-SG-REDIS" {
  name   = "for redis"
  vpc_id = aws_vpc.DEV-VPC.id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}*/