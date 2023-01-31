variable "sns" {
  description = "Map of necessary SNS topics"
  type        = map(any)
}

variable "subscriptions" {
  description = "Map of necessary SNS subscriptions"
  type        = any
}

variable "sqs_data" {
  description = "Data from SQS module"
  type        = list(any)
}
