output "sql_server_fqdn" {
  value = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "database_name" {
  value = azurerm_mssql_database.database.name
}


output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server

}
