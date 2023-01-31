data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "sns_policies" {
  for_each = var.sns_data[0]

  version   = "2008-10-17"
  policy_id = "__default_policy_ID"

  statement {
    sid    = "__default_statement_ID"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "SNS:GetTopicAttributes",
      "SNS:SetTopicAttributes",
      "SNS:AddPermission",
      "SNS:RemovePermission",
      "SNS:DeleteTopic",
      "SNS:Subscribe",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish",
      "SNS:Receive"
    ]
    resources = [
      each.value.arn
    ]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [data.aws_caller_identity.current.account_id]
    }
  }

  statement {
    sid    = "__console_pub_sub_0"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }
    actions = [
      "SNS:Publish",
      "SNS:Subscribe",
      "SNS:Receive"
    ]

    resources = [
      each.value.arn
    ]
  }
}

resource "aws_sns_topic_policy" "policies" {
  for_each = var.sns_data[0]

  arn    = each.value.arn
  policy = data.aws_iam_policy_document.sns_policies[each.key].json

  depends_on = [
    var.sns_data
  ]
}

data "aws_iam_policy_document" "sqs_policies" {
  for_each = var.sqs_data[0]

  version   = "2012-10-17"
  policy_id = "${each.value.arn}/SQSDefaultPolicy"

  statement {
    sid    = "__sender_receiver_statement"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }
    actions = [
      "SQS:SendMessage",
      "SQS:ChangeMessageVisibility",
      "SQS:DeleteMessage",
      "SQS:ReceiveMessage"
    ]

    resources = [
      each.value.arn
    ]
  }
}

resource "aws_sqs_queue_policy" "policies" {
  for_each = var.sqs_data[0]

  queue_url = each.value.id
  policy    = data.aws_iam_policy_document.sqs_policies[each.key].json

  depends_on = [
    var.sqs_data
  ]
}
