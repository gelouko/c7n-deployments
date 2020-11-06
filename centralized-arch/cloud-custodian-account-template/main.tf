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

resource "aws_iam_role" "custodian_lambda_execution_role" {
  name = var.custodian_lambda_execution_role_name
  description = "Used by Cloud Custodian deployed Lambdas to assume cross-account roles in other accounts."

  assume_role_policy = data.aws_iam_policy_document.custodian_lambda_execution_assume_role_policy.json

  tags = {
    Application = var.application_name
  }
}

resource "aws_iam_role_policy" "custodian_lambda_execution_role_inline_policy" {
  name = var.custodian_lambda_execution_role_inline_policy_name
  role = aws_iam_role.custodian_lambda_execution_role.id

  policy = data.aws_iam_policy_document.custodian_lambda_execution_role_policy_document.json
}

resource "aws_iam_role_policy_attachment" "custodian_lambda_execution_role_basic_policy_attachment" {
  role       = aws_iam_role.custodian_lambda_execution_role.name
  policy_arn = data.aws_iam_policy.aws_basic_lambda_execution_policy.arn
}

