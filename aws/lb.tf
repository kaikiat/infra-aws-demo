
resource "aws_lb" "gt_lb" {
  name               = "gt-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.gt_alb_sg.id]
  subnets            = [aws_subnet.gt_subnet_1.id, aws_subnet.gt_subnet_2.id]
}


resource "aws_lb_target_group" "gt_lb_tg" {
  name        = "gt-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"

  deregistration_delay = 60
  vpc_id               = aws_vpc.gt_vpc.id

  health_check {
    path     = "/"
    port     = "traffic-port"
    protocol = "HTTP"
  }
}

resource "aws_lb_listener" "gt_lb_listerner" {
  load_balancer_arn = aws_lb.gt_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gt_lb_tg.arn
  }
}
