resource "aws_alb" "this" {
  name = "${var.project}-ALB"
  security_groups = [var.http_sg, var.https_sg, var.vpc_traffic_sg]
  subnets         = var.public_subnet[*]

  tags = {
    Name = "${var.project}-ALB"
  }
}

resource "aws_alb_target_group" "this" {
  name     = "${var.project}-ALB-TargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 70
    path                = "/"
    port                = 80
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 60
    protocol            = "HTTP"
    matcher             = "200,202,301"
  }

  tags = {
    Name = "${var.project}-ALB-TargetGroup"
  }
}

resource "aws_alb_listener" "this" {
  load_balancer_arn = aws_alb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.this.arn
    type             = "forward"
  }
}

output "alb_public_dns" {
  value = aws_alb.this.dns_name
}
