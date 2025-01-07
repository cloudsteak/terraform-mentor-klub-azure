output "resource_group_id" {
  value = azurerm_resource_group.mentorklub.id
}

output "vnet_id" {
  value = azurerm_virtual_network.mentorklub.id
}

output "subnet_id" {
  value = azurerm_subnet.primary_subnet.id

}

output "storage_account_name" {
  value = azurerm_storage_account.primary_sa.name
}
