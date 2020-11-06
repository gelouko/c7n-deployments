data "aws_iam_policy_document" "custodian_event_forwarder_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "custodian_event_forwarder_role_policy_document" {
  statement {
    actions = [
      "events:PutEvents"
    ]

    resources = [
      local.custodian_event_bus_arn,
    ]
  }
}

data "aws_iam_policy_document" "custodian_cross_account_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.custodian_account_id}:role/${var.custodian_account_execution_role_name}"]
    }
  }
}

# Add only the necessary actions you need for your cross account role.
data "aws_iam_policy_document" "custodian_cross_account_role_policy_document" {
  statement {
    actions = [
      "s3:*"
    ]

    resources = [
      "*",
    ]
  }
}
