resource "azurerm_resource_group" "acr" {
  name     = "docker-${var.modules_resource_group_name}"
  location = var.location
  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Modulok"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.main_resource_group_name}acr"
  location            = var.location
  resource_group_name = azurerm_resource_group.acr.name
  sku                 = "Basic"
  admin_enabled       = true
  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Modulok"
  }
}
