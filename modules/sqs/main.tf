resource "aws_sqs_queue" "queues" {
  for_each = var.sqs

  name                       = each.key
  message_retention_seconds  = lookup(each.value, "message_retention_seconds", var.default_message_retention_seconds)
  visibility_timeout_seconds = lookup(each.value, "visibility_timeout_seconds", var.default_visibility_timeout_seconds)
  delay_seconds              = lookup(each.value, "delay_seconds", var.default_delay_seconds)
  sqs_managed_sse_enabled    = false
}
