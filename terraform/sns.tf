resource "aws_sns_topic" "alarms" {
  name = "${local.name}-alarms"
}
