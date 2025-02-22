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

variable "modules_resource_group_name_suffix" {
  type        = string
  description = "value of the Azure resource group name suffix for modules"
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
  }
  
}

variable "entra_id_group_name" {
  type = string
}

##################
# Database info  #
##################

variable "resource_group_name_prefix" {
  type        = string
  description = "value of the Azure resource group name prefix"
  default     = "db"
}

variable "db_username" {
  type        = string
  description = "value of the Azure database username"
  sensitive   = true
}

variable "db_password" {
  type        = string
  description = "value of the Azure database password"
  sensitive   = true
}

variable "db_name" {
  type        = string
  description = "value of the Azure database name"
}



