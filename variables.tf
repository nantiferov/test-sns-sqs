variable "sns" {
  description = "Map of SNS topics"
  type        = map(any)
}

variable "subscriptions" {
  description = "Map of SNS subscriptions"
  type        = any
}

variable "sqs" {
  description = "Map of SQS queues"
  type        = any
}
