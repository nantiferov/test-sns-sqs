variable "sqs" {
  description = "Map of necessary SQS queues"
  type        = any
}

variable "default_message_retention_seconds" {
  description = "Default message_retention_seconds"
  default     = 345600
}

variable "default_visibility_timeout_seconds" {
  description = "Default visibility_timeout_seconds"
  default     = 30
}

variable "default_delay_seconds" {
  description = "Default delay_seconds"
  default     = 0
}
