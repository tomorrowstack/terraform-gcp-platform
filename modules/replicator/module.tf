terraform {
  required_version = ">= 1.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.64.0"
    }
  }
}

resource "google_service_account" "replicator_service_account" {
  account_id   = var.service_account_name
  display_name = "${var.service_account_name} service account"
  project      = var.management_project_id
}

resource "google_project_service" "service_admin" {
  project            = var.management_project_id
  service            = "admin.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "service_cloudbilling" {
  project            = var.management_project_id
  service            = "cloudbilling.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "service_cloudresourcemanager" {
  project            = var.management_project_id
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_organization_iam_custom_role" "replicator_service_role" {
  role_id     = "${replace(var.service_account_name, "-", "_")}_service"
  org_id      = var.organization_id
  title       = "${var.service_account_name} service role"
  description = "Role for ${var.service_account_name} service account used for project replication"
  permissions = [
    "resourcemanager.folders.get",
    "resourcemanager.folders.list",
    "resourcemanager.organizations.get",
    "resourcemanager.projects.create",
    "resourcemanager.projects.get",
    "resourcemanager.projects.getIamPolicy",
    "resourcemanager.projects.list",
    "resourcemanager.projects.move",
    "resourcemanager.projects.setIamPolicy",
    "resourcemanager.projects.update",
    "resourcemanager.projects.createBillingAssignment",
    "resourcemanager.projects.deleteBillingAssignment",

    "serviceusage.services.enable",
    "serviceusage.services.get",

    "deploymentmanager.deployments.delete",
    "deploymentmanager.deployments.create",
    "deploymentmanager.deployments.update",
    "deploymentmanager.deployments.get",
  ]
}

resource "google_organization_iam_custom_role" "replicator_billing_role" {
  role_id     = "${replace(var.service_account_name, "-", "_")}_billing"
  org_id      = var.billing_organization_id
  title       = "${var.service_account_name} billing role"
  description = "Role for ${var.service_account_name} service account to create billing associations"
  permissions = [
    "billing.resourceAssociations.create"
  ]
}

resource "google_folder_iam_member" "replicator_service_account" {
  for_each = var.zone_folder_ids

  folder = each.value
  role   = google_organization_iam_custom_role.replicator_service_role.id
  member = "serviceAccount:${google_service_account.replicator_service_account.email}"
}

resource "google_billing_account_iam_member" "replicator_service_account" {
  billing_account_id = var.billing_account_id
  role               = google_organization_iam_custom_role.replicator_billing_role.id
  member             = "serviceAccount:${google_service_account.replicator_service_account.email}"
}

resource "google_service_account_key" "service_account_key" {
  service_account_id = google_service_account.replicator_service_account.id
}