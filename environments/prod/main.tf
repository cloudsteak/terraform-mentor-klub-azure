
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.80"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "mentorklub" {
  name     = var.main_resource_group_name
  location = var.location
  tags = {
    owner   = "CloudMentor"
    purpose = "Educational"
    type    = "Alap"
  }
}

# VNET Module
module "vnet" {
  source                   = "../../modules/vnet"
  subscription_id          = var.subscription_id
  main_resource_group_name = var.main_resource_group_name
  location                 = var.location
  vnet_address_space       = var.vnet_address_space
  subnet_address_prefix    = var.subnet_address_prefix

  # Only create resources if the module is enabled
  count = var.modules_enabled["vnet"] ? 1 : 0
}

# Network Gateway Module
module "natgw" {
  source                             = "../../modules/natgw"
  subscription_id                    = var.subscription_id
  main_resource_group_name           = var.main_resource_group_name
  location                           = var.location
  tags                               = var.tags
  modules_resource_group_name_suffix = var.modules_resource_group_name_suffix
  vnet_subnet_id                     = module.vnet[0].subnet_id

  # Only create resources if the module is enabled
  count = var.modules_enabled["natgw"] ? 1 : 0

  depends_on = [module.vnet]
}

# Storage Account Module
module "storage_account" {
  source                      = "../../modules/storage_account"
  storage_account_name_suffix = var.storage_account_name_suffix
  subscription_id             = var.subscription_id
  main_resource_group_name    = var.main_resource_group_name
  location                    = var.location
  tags                        = var.tags


  # Only create resources if the module is enabled
  count = var.modules_enabled["storage_account"] ? 1 : 0
}


