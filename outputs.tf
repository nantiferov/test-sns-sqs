output "sns_count" {
  description = "SNS topics total count"
  value       = length(module.sns.sns_data[0])
}

output "sqs_count" {
  description = "SQS queues total count"
  value       = length(module.sqs.sqs_data[0])
}
