resource "aws_ecr_repository" "nginx-login" {
  name                 = "nginx-login"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    Name = "nginx-login"
  }
}

resource "aws_ecr_repository" "nginx-main" {
  name                 = "nginx-main"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    Name = "nginx-main"
  }
}

resource "aws_ecr_repository" "nginx-order" {
  name                 = "nginx-order"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    Name = "nginx-order"
  }
}

resource "aws_ecr_repository" "nginx-reservation" {
  name                 = "nginx-reservation"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    Name = "nginx-reservation"
  }
}

resource "aws_ecr_repository" "nginx-signup" {
  name                 = "nginx-signup"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    Name = "nginx-signup"
  }
}

resource "aws_ecr_repository" "tomcat-login" {
  name                 = "tomcat-login"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    Name = "tomcat-login"
  }
}

resource "aws_ecr_repository" "tomcat-main" {
  name                 = "tomcat-main"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    Name = "tomcat-main"
  }
}

resource "aws_ecr_repository" "tomcat-order" {
  name                 = "tomcat-order"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    Name = "tomcat-order"
  }
}

resource "aws_ecr_repository" "tomcat-reservation" {
  name                 = "tomcat-reservation"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    Name = "tomcat-reservation"
  }
}

resource "aws_ecr_repository" "tomcat-signup" {
  name                 = "tomcat-signup"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    Name = "tomcat-signup"
  }
}