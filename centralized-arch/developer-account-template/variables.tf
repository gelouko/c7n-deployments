variable "region" {
  type = string
  default = "us-east-1"
  description = "The AWS region used to deploy the infrastructure"
}

variable "custodian_event_forwarder_name" {
  type = string
  default = "CloudCustodianEventForwarder"
  description = "Name of the forwarder rule used by the architecture."
}

variable "custodian_event_forwarder_role_name" {
  type = string
  default = "CloudCustodianEventForwarderRole"
  description = "Name of the role attached to the event forwarder."
}

variable "custodian_event_forwarder_role_inline_policy_name" {
  type = string
  default = "cloud-custodian-event-forwarder-policy"
  description = "Name of the inline policy for the event forwarder role."
}

variable "custodian_eventbus_region" {
  type = string
  default = "us-east-1"
  description = "The region where the events should be sent to (where the custodian account's infrastructure is deployed)"
}

variable "custodian_account_id" {
  type = string
  description = "The account ID of the custodian account."
}

variable "application_name" {
  type = string
  default = "CloudCustodian"
  description = "A name for the application to apply tags for the created resources."
}

variable "custodian_cross_account_role_name" {
  type = string
  default = "CloudCustodianCrossAccountRole"
  description = "Name of the role attached to the lambdas deployed by Cloud Custodian."
}

variable "custodian_cross_account_role_inline_policy_name" {
  type = string
  default = "cloud-custodian-cross-account-policy"
  description = "Name of the inline policy for the cross account role."
}

variable "custodian_account_execution_role_name" {
  type = string
  default = "CustodianLambdaExecutionRole"
  description = "The name of the role used in the Cloud Custodian account as the Lambdas' execution role."
}
