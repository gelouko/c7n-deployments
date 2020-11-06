variable "region" {
  type = string
  default = "us-east-1"
  description = "The AWS region used to deploy the infrastructure"
}

variable "event_forwarder_queue_name" {
  type = string
  default = "EventForwarderDLQ"
}

variable "custodian_lambda_execution_role_name" {
  type = string
  default = "CustodianLambdaExecutionRole"
}

variable "custodian_lambda_execution_role_inline_policy_name" {
  type = string
  default = "custodian-lambda-execution-role-inline-policy"
}

variable "cross_account_role_name" {
  type = string
  default = "CloudCustodianCrossAccountRole"
}

variable "application_name" {
  type = string
  default = "CloudCustodian"
  description = "A name for the application to apply tags for the created resources."
}

variable "organization_ids" {
  type = list(string)
  description = "A list of Organization ids in the format o-**** where the lambdas will be able to assume role."
}
