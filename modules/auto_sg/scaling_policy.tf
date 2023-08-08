resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${var.project}-ScaleUpPolicy"
  policy_type            = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${var.project}-ScaleDownPolicy"
  policy_type            = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
}


