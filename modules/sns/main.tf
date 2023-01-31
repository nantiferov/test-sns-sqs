resource "aws_sns_topic" "topics" {
  for_each = var.sns
  name     = each.key
}

resource "aws_sns_topic_subscription" "subcriptions" {
  for_each = var.subscriptions

  topic_arn     = aws_sns_topic.topics[split(":", each.key)[0]].arn
  protocol      = "sqs"
  endpoint      = lookup(var.sqs_data[0], split(":", each.key)[1], "") != "" ? var.sqs_data[0][split(":", each.key)[1]].arn : split(":", each.key)[1]
  filter_policy = lookup(each.value, "filter_policy", "") != "" ? jsonencode(lookup(each.value, "filter_policy", {})) : null
  depends_on = [
    aws_sns_topic.topics,
    var.sqs_data
  ]
}
