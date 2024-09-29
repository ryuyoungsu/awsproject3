# HAProxy
resource "aws_instance" "ON-PREMISE-PUB-HAProxy-1A" {
  count                       = 2
  ami                         = "ami-03a4942b8fcc1f29d"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.ON-PREMISE-SG-HAPROXY.id]
  subnet_id                   = aws_subnet.ON-PREMISE-PUB-1A.id
  key_name                    = "keypair"
  associate_public_ip_address = true

  # 특정 프라이빗 IP 주소 할당
  private_ip = element(
    ["10.240.1.11", "10.240.1.12"],
    count.index
  )

  tags = {
    Name = "ON-PREMISE-PUB-HAProxy${count.index + 1}-1A" # Name 태그에 인덱스를 사용하여 1부터 시작
  }
  # 원격 실행 프로비저너
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y keepalived",
      <<-EOF
        cat > /etc/keepalived/keepalived.conf << EOL
        vrrp_instance VI_1 {
            state ${count.index == 0 ? "MASTER" : "BACKUP"}
            interface eth0
            virtual_router_id 51
            priority ${count.index == 0 ? 100 : 99}
            advert_int 1
            authentication {
                auth_type PASS
                auth_pass 1111
            }
            virtual_ipaddress {
                10.240.1.51/24
            }
        }
        EOL'
      EOF
      ,"sudo systemctl restart keepalived"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("keypair.pem")  # 현재 키페어 경로
      host        = self.public_ip
    }
  }
}

# OpenSwan package 설치할 Instance
resource "aws_instance" "ON-PREMISE-PUB-VPN-MANAGED-SERVER-1A" {
  ami                         = "ami-06087749a704b8168"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.ON-PREMISE-SG-OPENSWAN.id]
  subnet_id                   = aws_subnet.ON-PREMISE-PUB-OPENSWAN-MANAGED-SERVER-1A.id
  key_name                    = "keypair"
  associate_public_ip_address = true
  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
    tags = {
      "Name" = "for OpenSwan"
    }
  }

  tags = {
    "Name" = "ON-PREMISE-PUB-VPN-MANAGED-SERVER-1A"
  }

  # 파일 업로드 프로비저너 (ipsec.conf 및 ipsec.secrets)
  provisioner "file" {
    source      = "/home/ubuntu/vpn/ipsec.conf"   # 로컬 ipsec.conf 파일 경로 (사용자 지정)
    destination = "/etc/ipsec.conf"               # EC2 인스턴스 내 경로

    connection {
      type        = "ssh"
      user        = "ec2-user"    # AMI에 따라 다를 수 있습니다. Amazon Linux는 ec2-user (예: ubuntu, centos 등)
      private_key = file("keypair.pem")
      host        = self.public_ip
    }
  }

  provisioner "file" {
    source      = "/home/ubuntu/vpn/ipsec.secrets"  # 로컬 ipsec.secrets 파일 경로 (사용자 지정)
    destination = "/etc/ipsec.secrets"              # EC2 인스턴스 내 경로

    connection {
      type        = "ssh"
      user        = "ec2-user"    # AMI에 따라 다를 수 있습니다. Amazon Linux는 ec2-user (예: ubuntu, centos 등)
      private_key = file("keypair.pem")
      host        = self.public_ip
    }
  }

  # 원격 실행 프로비저너
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",  # RedHat 계열의 경우
      "sudo yum install -y openswan",
      "sudo systemctl enable ipsec",
      "sudo systemctl start ipsec",
      "echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.conf",
      "echo 'net.ipv4.conf.default.rp_filter = 0' | sudo tee -a /etc/sysctl.conf",
      "echo 'net.ipv4.conf.default.accept_source_route = 0' | sudo tee -a /etc/sysctl.conf",
      "sudo sysctl -p",  # 변경 사항 적용
      <<-EOF
      sudo bash -c 'cat > /etc/ipsec.d/aws.conf << EOL
      conn Tunnel1
        authby=secret
        auto=start
        left=%defaultroute
        leftid=13.124.80.118
        right=3.34.165.198
        type=tunnel
        ikelifetime=8h
        keylife=1h
        phase2alg=aes128-sha1;modp1024
        ike=aes128-sha1;modp1024
        keyingtries=%forever
        keyexchange=ike
        leftsubnet=10.240.0.0/16
        rightsubnet=10.250.0.0/16
        dpddelay=10
        dpdtimeout=30
        dpdaction=restart_by_peer

      conn Tunnel2
        authby=secret
        auto=start
        left=%defaultroute
        leftid=13.124.80.118
        right=15.165.0.6
        type=tunnel
        ikelifetime=8h
        keylife=1h
        phase2alg=aes128-sha1;modp1024
        ike=aes128-sha1;modp1024
        keyingtries=%forever
        keyexchange=ike
        leftsubnet=10.240.0.0/16
        rightsubnet=10.250.0.0/16
        dpddelay=10
        dpdtimeout=30
        dpdaction=restart_by_peer
      EOL'
    EOF
    ,"sudo systemctl restart ipsec"
    ]

    connection {
      type     = "ssh"
      user     = "ec2-user"   # AMI에 따라 다를 수 있습니다. Amazon Linux는 ec2-user (예: ubuntu, centos 등)
      private_key = file("keypair.pem")  # 현재 SSH 키 경로
      host     = self.public_ip
    }
  }

  depends_on = [aws_security_group.ON-PREMISE-SG-OPENSWAN, aws_subnet.ON-PREMISE-PUB-OPENSWAN-MANAGED-SERVER-1A]
}

# Master Node
resource "aws_instance" "ON-PREMISE-PUB-MASTER-1A" {
  count                  = 3
  ami                    = "ami-03a4942b8fcc1f29d"
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.ON-PREMISE-PUB-1A.id
  vpc_security_group_ids = [aws_security_group.ON-PREMISE-SG-MASTERNODE.id]
  key_name               = "keypair"

  # 특정 프라이빗 IP 주소 할당
  private_ip = element(
    ["10.240.1.13", "10.240.1.14", "10.240.1.15"],
    count.index
  )

  tags = {
    Name = "ON-PREMISE-PUB-MASTER${count.index + 1}-1A" # Name 태그에 인덱스를 사용하여 1부터 시작
  }
}

# Worker Node
resource "aws_instance" "ON-PREMISE-PUB-WORKER-1A" {
  count                  = 2
  ami                    = "ami-03a4942b8fcc1f29d"
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.ON-PREMISE-PUB-1A.id
  vpc_security_group_ids = [aws_security_group.ON-PREMISE-SG-WORKERNODE.id]
  key_name               = "keypair"

  # 특정 프라이빗 IP 주소 할당
  private_ip = element(
    ["10.240.1.101", "10.240.1.102"],
    count.index
  )

  tags = {
    Name = "ON-PREMISE-PUB-WORKER${count.index + 1}-1A" # Name 태그에 인덱스를 사용하여 1부터 시작
  }
}

resource "aws_instance" "ON-PREMISE-PUB-MARIADB-1A" {
  ami                    = "ami-03a4942b8fcc1f29d"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.ON-PREMISE-SG-DB.id]
  subnet_id              = aws_subnet.ON-PREMISE-PUB-1A.id
  key_name               = "keypair"
  private_ip             = "10.240.1.201"

  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
    tags = {
      "Name" = "for MariaDB"
    }
  }

  tags = {
    Name = "ON-PREMISE-PUB-MARIADB-1A"
  }
}


/*resource "aws_instance" "MariaDB-Slave" {
  ami                    = "ami-03a4942b8fcc1f29d"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.ON-PREMISE-SG-DB.id]
  subnet_id              = aws_subnet.ON-PREMISE-PUB-1A.id
  key_name               = "keypair"
  private_ip             = "10.240.1.202"

  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
    tags = {
      "Name" = "MariaDB-Slave"
    }
  }

  tags = {
    Name = "MariaDB-Slave"
  }
}*/
