resource "azurerm_resource_group" "ai" {
  name     = "ai-${var.modules_resource_group_name}"
  location = var.location
  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Modulok"
  }
}

resource "azurerm_ai_services" "ai" {
  name                = "${var.main_resource_group_name}-openai"
  location            = var.location
  resource_group_name = azurerm_resource_group.acr.name
  sku_name            = "S0"
  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Modulok"
  }
}

