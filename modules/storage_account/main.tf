resource "azurerm_storage_account" "primary_sa" {
  name                     = "${var.main_resource_group_name}${var.storage_account_name_suffix}"
  location                 = var.location
  resource_group_name      = var.main_resource_group_name
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type

  tags = var.tags
}
