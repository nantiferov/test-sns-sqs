# test-sns-sqs

Example of random diffs in terraform for sns-sqs configuration

## Overview

This example uses local state and default AWS credentials provided via `AWS_PROFILE=<profile> terraform init/plan/apply`.

How to reproduce:

* SNS drift:
  * Add new SNS topic to terraform.tfvars with or without subscription to SQS
  * Run `terraform apply`
  * Add one more SNS topic to terraform.tfvars
  * Run `terraform plan/apply` and with high possibility you'll get diff in `Objects have changed outside of Terraform`, related to previously created SNS, before plan:

```terraform
Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have affected this plan:

  # module.sns.aws_sns_topic.topics["test-sns3"] has changed
  ~ resource "aws_sns_topic" "topics" {
        id                                       = "arn:aws:sns:eu-central-1:707731483551:test-sns3"
        name                                     = "test-sns3"
      ~ policy                                   = jsonencode(
          ~ {
              ~ Statement = [
                  ~ {
                      ~ Action    = [
                          - "SNS:GetTopicAttributes",
                          + "SNS:Subscribe",
                            "SNS:SetTopicAttributes",
                          - "SNS:AddPermission",
                            "SNS:RemovePermission",
                          - "SNS:DeleteTopic",
```

* SQS drift:
  * Add new SQS queue to terraform.tfvars
  * Run `terraform apply`
  * Add new SNS topic **AND/OR** SQS queue to terraform.tfvars
  * Run `terraform plan/apply` and with high possibility you'll get diff in `Objects have changed outside of Terraform`, related to previously created SQS, before plan:

```terraform
Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have affected this plan:

  # module.sqs.aws_sqs_queue.queues["test-sqs2"] has changed
  ~ resource "aws_sqs_queue" "queues" {
        id                                = "https://sqs.eu-central-1.amazonaws.com/707731483551/test-sqs2"
        name                              = "test-sqs2"
      + policy                            = jsonencode(
            {
              + Id        = "arn:aws:sqs:eu-central-1:707731483551:test-sqs2/SQSDefaultPolicy"
              + Statement = [
                  + {
                      + Action    = [
                          + "SQS:SendMessage",
                          + "SQS:ReceiveMessage",
                          + "SQS:DeleteMessage",
                          + "SQS:ChangeMessageVisibility",
                        ]
```

NOTE: `terraform.tfvars` file has prepared sns/sqs commented out.

### Versions

* Terraform v1.3.7
* provider registry.terraform.io/hashicorp/aws v4.52.0
