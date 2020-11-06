locals {
  custodian_event_bus_arn = "arn:aws:events:${var.custodian_eventbus_region}:${var.custodian_account_id}:event-bus/default"
}
