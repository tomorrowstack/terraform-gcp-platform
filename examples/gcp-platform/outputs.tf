output "replicator_service_account_email" {
  value = module.gcp_platform.replicator_service_account_email
}

output "replicator_service_account_key" {
  value     = module.gcp_platform.replicator_service_account_key
  sensitive = true
}

output "replicator_manual_configuration" {
  value = module.gcp_platform.replicator_manual_configuration
}