resource "azurerm_storage_account" "primary_sa" {
  name                     = "${var.main_resource_group_name}${var.storage_account_name_suffix}"
  location                 = var.location
  resource_group_name      = var.main_resource_group_name
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type

  tags = var.tags
}

# Add resource lock on storage account
resource "azurerm_management_lock" "mentorklub_sa_lock" {
  name       = "DeleteLockMentorKlubSA"
  scope      = azurerm_storage_account.primary_sa.id
  lock_level = "CanNotDelete"
  notes      = "This lock is to prevent user deletion of the MentorKlub Storage Account"

  timeouts {
    delete = "30m" # Extend delete timeout from the default (which is lower)
    create = "30m" # Extend create timeout from the default (which is lower)
  }
}
