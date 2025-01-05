resource "azurerm_mssql_server" "sql_server" {
  name                         = "${var.modules_resource_group_name}-sql"
  location                     = var.location
  resource_group_name          = var.modules_resource_group_name
  version                      = "12.0"
  administrator_login          = var.db_username
  administrator_login_password = var.db_password
  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Modulok"
  }


}

resource "azurerm_mssql_database" "database" {
  name                        = "webshop"
  server_id                   = azurerm_mssql_server.sql_server.id
  collation                   = "SQL_Latin1_General_CP1_CI_AS"
  auto_pause_delay_in_minutes = 60
  max_size_gb                 = 5
  min_capacity                = 0.5
  read_replica_count          = 0
  read_scale                  = false
  sku_name                    = "GP_S_Gen5_1"
  zone_redundant              = false

  threat_detection_policy {
    disabled_alerts      = []
    email_account_admins = "Disabled"
    email_addresses      = []
    retention_days       = 0
    state                = "Disabled"
  }
  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Modulok"
  }

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = false
  }
}


resource "azurerm_mssql_firewall_rule" "allow_public_access" {
  name             = "AllowPublicIP"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.1"
  end_ip_address   = "255.255.255.255"
}

