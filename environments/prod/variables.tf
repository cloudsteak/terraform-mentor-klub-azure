############################
# Enable / Disable modules #
############################

variable "modules_enabled" {
  description = "Map of modules to enable or disable."
  type        = map(bool)
  default = {
    vnet            = true
    storage_account = true
  }
}

variable "modules_resource_group_name_suffix" {
  type        = string
  description = "value of the Azure resource group name suffix for modules"

}

###########
# Tagging #
###########

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default = {
    owner   = "CloudMentor"
    purpose = "Educational"

  }
}

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

###############
# VNET Inputs #
###############


variable "vnet_address_space" {
  type        = list(string)
  description = "value of the Azure virtual network address space"
}

variable "subnet_address_prefix" {
  type        = string
  description = "value of the Azure subnet address prefix"
}


##########################
# Storage Account Inputs #
##########################

variable "storage_account_name_suffix" {
  type        = string
  description = "value of the Azure storage account suffix"
}

######
# AI #
######

variable "local_doc_directory_path" {
  type        = string
  description = "value of the local document directory path for RAG"
}
