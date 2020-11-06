data "aws_iam_policy_document" "custodian_lambda_execution_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "custodian_lambda_execution_role_policy_document" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    resources = [
      "arn:aws:iam::*:role/${var.cross_account_role_name}",
    ]

    condition {
      test = "StringEquals"
      variable = "aws:PrincipalOrgID"

      values = var.organization_ids
    }
  }
}

data "aws_iam_policy" "aws_basic_lambda_execution_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
