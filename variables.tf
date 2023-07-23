## ---------------------------------------------------------------------------------------------------------------------
## REQUIRED PARAMETERS
## --------------------------------------------------------------------------------------------------------------------- 
variable "organization_id" {
  type = string
}

variable "management_project_id" {
  type = string
}

variable "zone_folder_ids" {
  type = list(string)
}

variable "billing_organization_id" {
  type = string
}

variable "billing_account_id" {
  type = string
}

## ---------------------------------------------------------------------------------------------------------------------
## OPTIONAL PARAMETERS
## ---------------------------------------------------------------------------------------------------------------------
variable "replicator_service_account_name" {
  type    = string
  default = "replicator-service"
}