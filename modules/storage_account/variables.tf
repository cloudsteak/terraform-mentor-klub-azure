################
# Basic Inputs #
################
variable "subscription_id" {
  type        = string
  description = "value of the Azure subscription ID"
}

variable "main_resource_group_name" {
  type        = string
  description = "value of the Azure resource group name"
}

variable "location" {
  type        = string
  description = "value of the Azure location"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Alap"
  }
  
}

##########################
# Storage Account Inputs #
##########################

variable "storage_account_name_suffix" {
  type        = string
  description = "value of the Azure storage account suffix"
}

variable "storage_account_tier" {
  type        = string
  description = "value of the Azure storage account tier"
  default     = "Standard"
}

variable "storage_account_replication_type" {
  type        = string
  description = "value of the Azure storage account replication type"
  default     = "LRS"
}
