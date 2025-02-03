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

######################
# Custom Image info  #
######################

variable "resource_group_name_prefix" {
  type        = string
  description = "value of the Azure resource group name prefix"
  default     = "kep"
}

variable "storage_account_name" {
  type        = string
    description = "value of the Azure storage account name"

}

variable "vnet_subnet_id" {
  type        = string
  description = "value of the Azure virtual network subnet ID"
}

variable "image_vm_1_prefix" {
  type        = string
  description = "value of the Azure virtual machine name prefix"
  default     = "image1"
}

variable "image_vm_1_size" {
  type        = string
  description = "value of the Azure virtual machine size"
  default     = "Standard_B1s"
}

variable "image_vm_1_username" {
  type        = string
  description = "value of the Azure virtual machine username"
  default     = "rendszergazda"
}

variable "image_vm_1_password" {
  type        = string
  description = "value of the Azure virtual machine password"
  sensitive   = true
  default     = "Ab123456789!"
}

variable "storage_account_script_container_name" {
  type        = string
  description = "value of the Azure storage account container name for scripts"
  default     = "scripts"
}


variable "evn_file_path" {
  # Note that for my example this is expected to be the full path
  # to the file, not just the filename. Terraform idiom is to be
  # explicit about this sort of thing, rather than relying on
  # environment variables like HOME.
  type = string
  description = "Path to the environment file"
  default = "./.env"
}
