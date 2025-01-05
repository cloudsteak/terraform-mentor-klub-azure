resource "azurerm_resource_group" "halozat" {
  name     = "halozat-${var.modules_resource_group_name}"
  location = var.location
  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Modulok"
  }
}

# Public IP for NAT Gateway
resource "azurerm_public_ip" "nat_gw_pip" {
  name                = "${var.main_resource_group_name}-nat-gw-pip"
  location            = var.location
  resource_group_name = azurerm_resource_group.halozat.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Modulok"
  }
}

# NAT Gateway
resource "azurerm_nat_gateway" "nat_gw" {
  name                    = "${var.main_resource_group_name}-nat-gw"
  location                = var.location
  resource_group_name     = azurerm_resource_group.halozat.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Modulok"
  }
}

# NAT Gateway Public IP Association
resource "azurerm_nat_gateway_public_ip_association" "nat_gw_pip_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gw.id
  public_ip_address_id = azurerm_public_ip.nat_gw_pip.id
}

# Associate NAT Gateway with Subnet
resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gw_assoc" {
  subnet_id      = "/subscriptions/${var.subscription_id}/resourceGroups/${var.main_resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.main_resource_group_name}-vnet/subnets/${var.main_resource_group_name}-vnet-subnet-01"
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
}
