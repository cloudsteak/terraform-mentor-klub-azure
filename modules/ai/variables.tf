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
    type      = "Alap"
  }
  
}

#############
# AI Inputs #
#############

variable "resource_group_name_prefix" {
  type        = string
  description = "value of the Azure resource group name prefix"
  default     = "ai"
}

variable "ai_name_suffix" {
  type        = string
  description = "value of the Azure NAT gateway name suffix"
  default     = "ai"
}

variable "doc_container_name" {
  type        = string
  description = "value of the Azure container name for AI"
  default     = "dokumentumok"
}

variable "doc_container_access_type" {
  type        = string
  description = "value of the Azure container access type for AI"
  default     = "private"
}

variable "local_doc_directory_path" {
  type        = string
  description = "value of the local document directory path for RAG"
  default = "../../files/docs"
}

variable "rag_storage_account_name" {
  type        = string
  description = "value of the Azure storage account suffix for RAG"
}
