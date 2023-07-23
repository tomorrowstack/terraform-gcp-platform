output "replicator_service_account_email" {
  value = module.replicator.service_account_email
}

output "replicator_service_account_key" {
  value     = module.replicator.service_account_key
  sensitive = true
}

output "replicator_manual_configuration" {
  value = module.replicator.manual_configuration
}