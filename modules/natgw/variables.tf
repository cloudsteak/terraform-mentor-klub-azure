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
###############
# NAT Gateway #
###############

variable "resource_group_name_prefix" {
  type        = string
  description = "value of the Azure resource group name prefix"
  default     = "halozat"
}

variable "nat_gateway_name_suffix" {
  type        = string
  description = "value of the Azure NAT gateway name suffix"
  default     = "natgw"
}

variable "nat_gateway_pip_suffix" {
  type        = string
  description = "value of the Azure NAT gateway public IP name suffix"
  default     = "pip"
}

variable "nat_gateway_pip_allocation_method" {
  type        = string
  description = "value of the Azure NAT gateway public IP allocation method"
  default     = "Static"
}

variable "nat_gateway_pip_sku" {
  type        = string
  description = "value of the Azure NAT gateway public IP SKU"
  default     = "Standard"

}

variable "vnet_subnet_id" {
  type        = string
  description = "value of the Azure virtual network subnet ID"
}
