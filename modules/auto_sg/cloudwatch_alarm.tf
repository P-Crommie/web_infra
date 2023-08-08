resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_name          = "${var.project}-scaleUpAlarm"
  alarm_description   = "Auto-Scale-Up-CPU-Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "50"
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.this.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_up.arn]

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-ScaleUpAlarm"
  })
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_name          = "${var.project}-scaleDownAlarm"
  alarm_description   = "Auto-Scale-Down-CPU-Alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.this.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_down.arn]

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-ScaleDownAlarm"
  })
}
