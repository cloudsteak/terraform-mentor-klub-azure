resource "azurerm_resource_group" "halozat" {
  name     = "${var.resource_group_name_prefix}-${var.modules_resource_group_name_suffix}"
  location = var.location
  tags = var.tags
}

# Add resource lock on natwg resource group
resource "azurerm_management_lock" "natgw_rg_lock" {
  name       = "DeleteLockNatGW"
  scope      = azurerm_resource_group.halozat.id
  lock_level = "CanNotDelete"
  notes      = "This lock is to prevent user deletion of the NatGW Resource Group"

  timeouts {
    delete = "30m" # Extend delete timeout from the default (which is lower)
    create = "30m" # Extend create timeout from the default (which is lower)
  }
}

# Fetch the Entradata ID Group
data "azuread_group" "mentorklub_user_group_name" {
  display_name = var.entra_id_group_name
}

# Assign the Contributor role to the Entradata ID Group
resource "azurerm_role_assignment" "mentorklub_user_group_name" {
  scope                = azurerm_resource_group.halozat.id
  role_definition_name = "Reader"
  principal_id         = replace(data.azuread_group.mentorklub_user_group_name.id, "//groups//", "")

}

# Public IP for NAT Gateway
resource "azurerm_public_ip" "nat_gw_pip" {
  name                = "${var.main_resource_group_name}-${var.nat_gateway_name_suffix}-${var.nat_gateway_pip_suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.halozat.name
  allocation_method   = var.nat_gateway_pip_allocation_method
  sku                 = var.nat_gateway_pip_sku
  tags = var.tags

  depends_on = [ azurerm_resource_group.halozat, var.main_resource_group_name ]
}

# NAT Gateway
resource "azurerm_nat_gateway" "nat_gw" {
  name                    = "${var.main_resource_group_name}-${var.nat_gateway_name_suffix}"
  location                = var.location
  resource_group_name     = azurerm_resource_group.halozat.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  tags = var.tags
}

# NAT Gateway Public IP Association
resource "azurerm_nat_gateway_public_ip_association" "nat_gw_pip_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gw.id
  public_ip_address_id = azurerm_public_ip.nat_gw_pip.id
}

# Associate NAT Gateway with Subnet
resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gw_assoc" {
  subnet_id      = var.vnet_subnet_id
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
}

