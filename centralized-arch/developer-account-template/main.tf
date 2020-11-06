terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_cloudwatch_event_rule" "custodian_event_forwarder" {
  name        = var.custodian_event_forwarder_name
  description = "Detects all the necessary events to the Custodian account. Change the event pattern according to the events you will be tracking."

  event_pattern = <<EOF
{
  "source": [
    "aws.s3"
  ]
}
EOF
}

resource "aws_cloudwatch_event_target" "custodian_event_forwarder_target" {
  rule      = aws_cloudwatch_event_rule.custodian_event_forwarder.name
  target_id = "ForwardToCustodianEventBus"
  arn       = local.custodian_event_bus_arn
  role_arn  = aws_iam_role.custodian_event_forwarder_role.arn
}

resource "aws_iam_role" "custodian_event_forwarder_role" {
  name = var.custodian_event_forwarder_role_name
  description = "Role used to forward events to the custodian event bus."

  assume_role_policy = data.aws_iam_policy_document.custodian_event_forwarder_assume_role_policy.json

  tags = {
    Application = var.application_name
  }
}

resource "aws_iam_role_policy" "custodian_event_forwarder_role_inline_policy" {
  name = var.custodian_event_forwarder_role_inline_policy_name
  role = aws_iam_role.custodian_event_forwarder_role.id

  policy = data.aws_iam_policy_document.custodian_event_forwarder_role_policy_document.json
}

resource "aws_iam_role" "custodian_cross_account_role" {
  name = var.custodian_cross_account_role_name
  description = "Role used to apply filters and actions on the developer account's resources."

  assume_role_policy = data.aws_iam_policy_document.custodian_cross_account_assume_role_policy.json

  tags = {
    Application = var.application_name
  }
}

resource "aws_iam_role_policy" "custodian_cross_account_role_inline_policy" {
  name = var.custodian_cross_account_role_inline_policy_name
  role = aws_iam_role.custodian_cross_account_role.id

  policy = data.aws_iam_policy_document.custodian_cross_account_role_policy_document.json
}
