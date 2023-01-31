output "sqs_data" {
  description = "All data for created SNS topics"
  value       = aws_sqs_queue.queues.*
}
