resource "azurerm_resource_group" "ai" {
  name     = "${var.resource_group_name_prefix}-${var.modules_resource_group_name_suffix}"
  location = var.location
  tags = var.tags
}

locals {
  deployment_data = jsondecode(file("../../fajlok/openai_deployments.json"))
}

module "openai" {
  source  = "Azure/openai/azurerm"
  version = "0.1.5"
  # insert the 2 required variables here
  account_name                  = "${var.main_resource_group_name}-${var.ai_name_suffix}"
  custom_subdomain_name         = "${var.main_resource_group_name}-${var.ai_name_suffix}"
  public_network_access_enabled = true
  location                      = var.location
  resource_group_name           = azurerm_resource_group.ai.name
  deployment                    = local.deployment_data
  tags = var.tags
  depends_on = [azurerm_resource_group.ai]

}


resource "azurerm_storage_container" "rag_container" {
  name                  = var.doc_container_name
  storage_account_name  = "${var.rag_storage_account_name}"
  container_access_type = var.doc_container_access_type
  depends_on = [var.rag_storage_account_name]
}



resource "azurerm_storage_blob" "file_upload" {
  for_each               = fileset(var.local_doc_directory_path, "*.md") # Match md files in the directory
  name                   = each.value                                    # Blob name (same as the file name)
  storage_account_name   = "${var.main_resource_group_name}sa"
  storage_container_name = azurerm_storage_container.rag_container.name
  type                   = "Block"
  source                 = "${var.local_doc_directory_path}/${each.value}" # Full path to the local file
  depends_on = [azurerm_storage_container.rag_container]
}
