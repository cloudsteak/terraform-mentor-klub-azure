terraform {

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate21526"
    container_name       = "tfstate"
    key                  = "dynamic/terraform.tfstate"
  }
}


