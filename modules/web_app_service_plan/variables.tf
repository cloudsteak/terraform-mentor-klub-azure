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
  default = {
    owner   = "CloudMentor"
    purpose = "Educational"
    type    = "Alap"
  }
}

variable "entra_id_group_name" {
  type = string
}

####################
# App Service Plan #
####################

variable "resource_group_name_prefix" {
  type        = string
  description = "value of the Azure resource group name prefix"
  default     = "web"
}

variable "app_service_plan_name_suffix" {
  type        = string
  description = "value of the Azure app service plan suffix"
  default = "asp"
}

variable "app_service_plan_sku" {
  type        = string
  description = "value of the Azure app service plan SKU"
  default = "B1"
}


variable "app_service_plan_capacity" {
  type        = number
  description = "value of the Azure app service plan capacity"
  default = 1
}


variable "web_app_plan_os" {
  type        = string
  description = "value of the Azure app service plan OS"
  default = "Linux"
}

