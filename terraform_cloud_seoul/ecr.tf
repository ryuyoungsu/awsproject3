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

/*resource "null_resource" "delete_ecr_images_and_repositories" {
  depends_on = [
    aws_ecr_repository.nginx-login,
    aws_ecr_repository.nginx-main,
    aws_ecr_repository.nginx-order,
    aws_ecr_repository.nginx-reservation,
    aws_ecr_repository.nginx-signup,
    aws_ecr_repository.tomcat-login,
    aws_ecr_repository.tomcat-main,
    aws_ecr_repository.tomcat-order,
    aws_ecr_repository.tomcat-reservation,
    aws_ecr_repository.tomcat-signup
  ]

  provisioner "local-exec" {
    command = <<EOT
      REPO_NAMES="nginx-login nginx-main nginx-order nginx-reservation nginx-signup tomcat-login tomcat-main tomcat-order tomcat-reservation tomcat-signup"
      for REPO in $REPO_NAMES; do
        echo "리포지토리에서 모든 이미지 삭제 중: \$REPO"
        # aws ecr list-images : 모든 이미지를 조회
        IMAGE_IDS=$(aws ecr list-images --repository-name \$REPO --query 'imageIds[*]' --output json | jq -c '.[]')

        if [ "\$IMAGE_IDS" != "[]" ]; then
          echo "\$REPO 리포지토리에 이미지가 존재합니다. 이미지 삭제 중..."
          echo "\$IMAGE_IDS" | jq -c '.[]' | while read image; do
            DIGEST=$(echo \$image | jq -r '.imageDigest')
            TAG=$(echo \$image | jq -r '.imageTag // empty')

            # aws ecr batch-delete-image : 태그가 있는 경우 태그로 삭제, 태그가 없으면 다이제스트로 삭제
            if [ -n "\$TAG" ]; then
              aws ecr batch-delete-image --repository-name \$REPO --image-ids imageTag=\$TAG
            else
              aws ecr batch-delete-image --repository-name \$REPO --image-ids imageDigest=\$DIGEST
            fi
          done
        else
          echo "\$REPO 리포지토리에 삭제할 이미지가 없습니다."
        fi
        echo "리포지토리 삭제 중: \$REPO"
        # delete-repository --force : 리포지토리 강제 삭제
        aws ecr delete-repository --repository-name \$REPO --force
      done
    EOT
  }
}*/
