terraform {
  required_version = ">= 1.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.64.0"
    }
  }
}

module "replicator" {
  source = "./modules/replicator/"

  organization_id         = var.organization_id
  management_project_id   = var.management_project_id
  service_account_name    = var.replicator_service_account_name
  zone_folder_ids         = var.zone_folder_ids
  billing_organization_id = var.billing_organization_id
  billing_account_id      = var.billing_account_id
}