# 호스팅 영역 생성
resource "aws_route53_zone" "route53" {
  name = "youngsu.shop"
}

/*resource "aws_route53_record" "alb_record" {    # A 레코드로 호스팅 영역 생성
  zone_id = aws_route53_zone.route53.zone_id
  name    = "youngsu.shop"
  type    = "A"

  alias {
    name                   = aws_lb.my_alb.dns_name  # 항상 최신 ALB DNS 이름을 자동으로 참조
    zone_id                = aws_lb.my_alb.zone_id   # 항상 최신 ALB의 호스팅 영역 ID 참조
    evaluate_target_health = true
  }
}*/