output "vpc_id" {
  description = "VPC id"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "Public subnet id"
  value       = aws_subnet.public.id
}

output "security_group_id" {
  description = "Web security group id"
  value       = aws_default_security_group.web.id
}

output "lambda_function_arn" {
  description = "Lambda function ARN"
  value       = aws_lambda_function.worker.arn
}

output "alarm_name" {
  description = "CloudWatch alarm name"
  value       = aws_cloudwatch_metric_alarm.lambda_errors.alarm_name
}

output "event_rule_arn" {
  description = "EventBridge rule ARN"
  value       = aws_cloudwatch_event_rule.schedule.arn
}

output "sns_topic_arn" {
  description = "SNS topic ARN for alarms"
  value       = aws_sns_topic.alarms.arn
}

output "failure_demo_table_arn" {
  description = "ARN of the failure-demo DynamoDB table. Null unless enable_failure_demo is true."
  value       = one(aws_dynamodb_table.bad_name[*].arn)
}
