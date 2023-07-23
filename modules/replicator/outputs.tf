output "service_account_unique_id" {
  value = google_service_account.replicator_service_account.unique_id
}

output "service_account_key" {
  value     = google_service_account_key.service_account_key.private_key
  sensitive = true
}

output "service_account_email" {
  value = google_service_account.replicator_service_account.email
}

output "manual_configuration" {
  value = <<EOF
  Using 'Google Workspace Admin Console' add manually ${google_service_account.replicator_service_account.email} with id '${google_service_account.replicator_service_account.unique_id}' to 'Groups Admin' role.
  @Account > Admin roles > Groups Admin > Assign admin > Assing service principal > ${google_service_account.replicator_service_account.email}
  EOF
}
