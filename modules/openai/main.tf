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

locals {
  deployment_data = jsondecode(file("../fajlok/openai_deployments.json/"))
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
  deployment                    = local.deployment_data
  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Modulok"
  }
  depends_on = [azurerm_resource_group.ai]

}


resource "azurerm_storage_container" "rag_container" {
  name                  = "ai-forras"
  storage_account_name  = "${var.main_resource_group_name}sa"
  container_access_type = "private"
}



resource "azurerm_storage_blob" "file_upload" {
  for_each               = fileset(var.local_doc_directory_path, "*.md") # Match md files in the directory
  name                   = each.value                                    # Blob name (same as the file name)
  storage_account_name   = "${var.main_resource_group_name}sa"
  storage_container_name = azurerm_storage_container.rag_container.name
  type                   = "Block"
  source                 = "${var.local_doc_directory_path}/${each.value}" # Full path to the local file
}
