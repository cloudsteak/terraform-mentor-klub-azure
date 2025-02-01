output "storage_account_name" {
  value = azurerm_storage_account.primary_sa.name
}

output "storage_account_id" {
  value = azurerm_storage_account.primary_sa.id
}
