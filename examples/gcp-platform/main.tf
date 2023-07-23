terraform {
  backend "gcs" {
    prefix = "{...}"
    bucket = "{...}"
  }
}

module "gcp_platform" {
  source = "tomorrowstack/platform/gcp"

  organization_id       = "{...}"
  management_project_id = "{...}"

  zone_folder_ids = [
    "..."
  ]

  billing_organization_id = "{...}"
  billing_account_id      = "{...}"
}