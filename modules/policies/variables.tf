variable "sns_data" {
  description = "Data from SNS module"
  type        = list(any)
}

variable "sqs_data" {
  description = "Data from SQS module"
  type        = list(any)
}
