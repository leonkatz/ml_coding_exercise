resource "aws_cloudwatch_log_group" "ec2_log_group" {
  name = "/aws/ec2/ML-EC2-Logs"
}

resource "aws_cloudwatch_log_stream" "ec2_log_stream" {
  name           = "ML-EC2-Log-Stream"
  log_group_name = aws_cloudwatch_log_group.ec2_log_group.name
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_alarm" {
  alarm_name          = "HighCPUAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.alarm_notifications.arn]

  dimensions = {
    InstanceId = aws_instance.ml_ec2.id
  }
  tags = {
    Name = "HighCPUAlarm"
  }
}

resource "aws_cloudwatch_metric_alarm" "status_check_failed_alarm" {
  alarm_name          = "StatusCheckFailed"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "0"
  alarm_description   = "This metric triggers when an instance or system status check fails"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.alarm_notifications.arn]


  dimensions = {
    InstanceId = aws_instance.ml_ec2.id
  }

  tags = {
    Name = "StatusCheckFailed"
  }
}

resource "aws_sns_topic" "alarm_notifications" {
  name = "AlarmNotifications"
  tags = {
    Name = "alarm-notifications"
  }
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alarm_notifications.arn
  protocol  = "email"
  endpoint  = "hadrian@leonkatz.org"

}
