resource "aws_autoscaling_group" "this" {
  name             = "${var.project}-ScalingGroup"
  desired_capacity = var.scaling_group_desired_capacity
  max_size         = var.scaling_group_max_size
  min_size         = var.scaling_group_min_size

  vpc_zone_identifier = var.private_subnet[*]
  target_group_arns   = [aws_alb_target_group.this.arn]

  health_check_grace_period = var.scaling_group_health_check_grace_period
  health_check_type         = var.scaling_group_health_check_type

  launch_template {
    id      = aws_launch_template.this.id
    version = var.scaling_group_launch_template_verson
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = var.scaling_group_instance_fresh_triggers
  }

  tag {
    key                 = "scaling"
    value               = "yes"
    propagate_at_launch = true
  }
}
