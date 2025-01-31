resource "azurerm_resource_group" "acr" {
  name     = "${var.resource_group_name_prefix}-${var.modules_resource_group_name_suffix}"
  location = var.location
  tags = var.tags
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.main_resource_group_name}acr"
  location            = var.location
  resource_group_name = azurerm_resource_group.acr.name
  sku                 = "Basic"
  admin_enabled       = true
  tags = var.tags
}
