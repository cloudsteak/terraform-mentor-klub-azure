resource "azurerm_resource_group" "acr" {
  name     = "${var.resource_group_name_prefix}-${var.modules_resource_group_name_suffix}"
  location = var.location
  tags = var.tags
}

# Add resource lock on Docker resource group
resource "azurerm_management_lock" "mentorklub_acr_lock" {
  name       = "DeleteLockMentorKlubAcr"
  scope      = azurerm_container_registry.acr.id
  lock_level = "CanNotDelete"
  notes      = "This lock is to prevent user deletion of the MentorKlub ACR"
  
  timeouts {
    create = "30m"
    delete = "30m"
  }
}

 
# Fetch the Entradata ID Group
data "azuread_group" "mentorklub_user_group_name" {
  display_name = var.entra_id_group_name
}

# Assign the Contributor role to the Entradata ID Group
resource "azurerm_role_assignment" "mentorklub_user_group_name" {
  scope                = azurerm_resource_group.acr.id
  role_definition_name = "Contributor"
  principal_id         = replace(data.azuread_group.mentorklub_user_group_name.id, "//groups//", "")
}


resource "azurerm_container_registry" "acr" {
  name                = "${var.main_resource_group_name}acr"
  location            = var.location
  resource_group_name = azurerm_resource_group.acr.name
  sku                 = "Basic"
  admin_enabled       = true
  tags = var.tags
}
