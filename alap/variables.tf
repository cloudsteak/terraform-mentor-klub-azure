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
  default     = "mentorklub2025"
}

variable "location" {
  type        = string
  description = "value of the Azure location"
  default     = "Sweden Central"
}

###############
# VNET Inputs #
###############


variable "vnet_address_space" {
  type        = list(string)
  description = "value of the Azure virtual network address space"
  default     = ["10.10.0.0/16"]
}

variable "subnet_address_prefix" {
  type        = string
  description = "value of the Azure subnet address prefix"
  default     = "10.10.8.0/22"
}


