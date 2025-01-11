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
  default = {
    owner   = "CloudMentor"
    purpose = "Educational"
    type    = "Alap"
  }
}

###############
# VNET Inputs #
###############

variable "vnet_name_suffix" {
  type        = string
  description = "value of the Azure virtual network name suffix"
  default     = "vnet"
}

variable "subnet_1_name" {
  type        = string
  description = "value of the Azure subnet 1 name"
  default     = "alap"

}

variable "nsg_name_suffix" {
  type        = string
  description = "value of the Azure network security group name suffix"
  default     = "nsg"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "value of the Azure virtual network address space"
}

variable "subnet_address_prefix" {
  type        = string
  description = "value of the Azure subnet address prefix"
}
