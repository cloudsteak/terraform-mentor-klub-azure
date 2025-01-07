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

module "openai" {
  source  = "Azure/openai/azurerm"
  version = "0.1.5"
  # insert the 2 required variables here
  account_name                  = "${var.main_resource_group_name}-openai"
  custom_subdomain_name         = "${var.main_resource_group_name}-openai"
  public_network_access_enabled = true
  location                      = var.location
  resource_group_name           = azurerm_resource_group.ai.name
  deployment = {
    "chat_model-35" = {
      name          = "gpt-35-turbo"
      model_format  = "OpenAI"
      model_name    = "gpt-35-turbo"
      model_version = "1106"
      scale_type    = "Standard"
      capacity      = 200
    },
    "chat_model-4o" = {
      name          = "gpt-4o"
      model_format  = "OpenAI"
      model_name    = "gpt-4o"
      model_version = "2024-05-13"
      scale_type    = "Standard"
      capacity      = 45
    },
    "chat_model-4o-mini" = {
      name          = "gpt-4o-mini"
      model_format  = "OpenAI"
      model_name    = "gpt-4o-mini"
      model_version = "2024-07-18"
      scale_type    = "Standard"
      capacity      = 400
    },
    "embedding_model" = {
      name          = "text-embedding-ada-002"
      model_format  = "OpenAI"
      model_name    = "text-embedding-ada-002"
      model_version = "2"
      scale_type    = "Standard"
      capacity      = 180
    }
  }
  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Modulok"
  }
}



