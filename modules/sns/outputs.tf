output "sns_data" {
  description = "All data for created SNS topics"
  value       = aws_sns_topic.topics.*
}
