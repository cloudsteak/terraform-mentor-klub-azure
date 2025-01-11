output "resource_group_id" {
  value = azurerm_resource_group.mentorklub.id
}

output "vnet_id" {
  value = var.modules_enabled.vnet ? module.vnet[0].vnet_id : null
}

output "subnet_id" {
  value = var.modules_enabled.vnet ? module.vnet[0].subnet_id : null
}

output "natgw_resource_group_name" {
  value = var.modules_enabled.natgw ? module.natgw[0].resource_group_name : null
}

output "storage_account_name" {
  value = var.modules_enabled.storage_account ? module.storage_account[0].storage_account_name : null
}
