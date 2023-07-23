variable "organization_id" {
  type = string
}

variable "management_project_id" {
  type = string
}

variable "service_account_name" {
  type = string
}

variable "zone_folder_ids" {
  type = set(string)
}

variable "billing_organization_id" {
  type = string
}

variable "billing_account_id" {
  type = string
}
