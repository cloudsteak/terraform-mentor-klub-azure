# This file is used to define the outputs of the modules that are enabled in the environment
# The outputs are used to display the values of the resources created by the modules
# The outputs are displayed after the terraform apply command is executed
# The outputs are displayed in the terminal
output "vnet_id" {
  value = var.modules_enabled.vnet ? module.vnet[0].vnet_id : null
}

output "subnet_id" {
  value = var.modules_enabled.vnet ? module.vnet[0].subnet_id : null
}

output "natgw_resource_group_name" {
  value = var.modules_enabled.natgw ? module.natgw[0].resource_group_name : null
}

output "ai_resource_group_name" {
  value = var.modules_enabled.ai ? module.ai[0].resource_group_name : null
}

output "storage_account_name" {
  value = var.modules_enabled.storage_account ? module.storage_account[0].storage_account_name : null
}

output "acr_login_server" {
  value = var.modules_enabled.arc ? module.arc[0].acr_login_server : null
}

output "sql_server_fqdn" {
  value = var.modules_enabled.sql ? module.sql[0].sql_server_fqdn : null
}

output "sql_database_name" {
  value = var.modules_enabled.sql ? module.sql[0].database_name : null

}
