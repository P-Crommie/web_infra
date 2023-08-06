resource "aws_autoscaling_group" "this" {
  name             = "${var.project}-ScalingGroup"
  desired_capacity = 3
  max_size         = 5
  min_size         = 3

  vpc_zone_identifier = var.private_subnet[*]
  target_group_arns   = [aws_alb_target_group.this.arn]

  health_check_grace_period = 300
  health_check_type         = "EC2"

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity"]
  }

  tag {
    key                 = "scaling"
    value               = "yes"
    propagate_at_launch = true
  }
}
