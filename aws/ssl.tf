resource "aws_acm_certificate" "gt_acm_cert" {
  domain_name       = "gtawsinfrademo.net"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "gtawsinfrademo.net SSL certificate"
  }
}


resource "aws_acm_certificate_validation" "gt_certificate_validation" {
  certificate_arn         = aws_acm_certificate.gt_acm_cert.arn
  validation_record_fqdns = [for record in aws_acm_certificate.gt_acm_cert.domain_validation_options : record.resource_record_name]
}


resource "aws_lb_listener" "gt_lb_listerner_https" {
  load_balancer_arn = aws_lb.gt_lb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate_validation.gt_certificate_validation.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gt_lb_tg.arn
  }
}

resource "aws_route53_record" "gt_r53_record" {
  zone_id = "Z05033771B5VHNTYW0XPU"
  name    = "gtawsinfrademo.net"
  type    = "A"
  alias {
    name                   = aws_lb.gt_lb.dns_name
    zone_id                = aws_lb.gt_lb.zone_id
    evaluate_target_health = false
  }
}
