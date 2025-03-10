resource "azurerm_resource_group" "db" {
  name     = "${var.resource_group_name_prefix}-${var.modules_resource_group_name_suffix}"
  location = var.location
  tags = var.tags
  depends_on = [
    var.main_resource_group_name
  ]
}

# Add resource lock on db resource group
resource "azurerm_management_lock" "mentorklub_db_rg_lock" {
  name       = "DeleteLockMentorKlubDBRG"
  scope      = azurerm_resource_group.db.id
  lock_level = "CanNotDelete"
  notes      = "This lock is to prevent user deletion of the MentorKlub DB resource group"

  timeouts {
    delete = "30m"  # Extend delete timeout from the default (which is lower)
  }
}

# Fetch the Entradata ID Group
data "azuread_group" "mentorklub_user_group_name" {
  display_name = var.entra_id_group_name
}

# Assign the Contributor role to the Entradata ID Group
resource "azurerm_role_assignment" "mentorklub_user_group_name" {
  scope                = azurerm_resource_group.db.id
  role_definition_name = "Reader"
  principal_id         = replace(data.azuread_group.mentorklub_user_group_name.id, "//groups//", "")

}

resource "azurerm_mssql_server" "sql_server" {
  name                         = "${var.main_resource_group_name}-sql"
  location                     = var.location
  resource_group_name          = azurerm_resource_group.db.name
  version                      = "12.0"
  administrator_login          = var.db_username
  administrator_login_password = var.db_password
  tags = var.tags


}

resource "azurerm_mssql_database" "database" {
  name                        = var.db_name
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
  tags = var.tags

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

