module "sns" {
  source        = "./modules/sns"
  sns           = var.sns
  subscriptions = var.subscriptions
  sqs_data      = module.sqs.sqs_data
}

module "sqs" {
  source = "./modules/sqs"
  sqs    = var.sqs
}

module "policies" {
  source   = "./modules/policies"
  sns_data = module.sns.sns_data
  sqs_data = module.sqs.sqs_data
}
