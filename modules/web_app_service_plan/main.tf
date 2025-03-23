resource "azurerm_resource_group" "web" {
  name     = "${var.resource_group_name_prefix}-${var.modules_resource_group_name_suffix}"
  location = var.location
  tags     = var.tags
  depends_on = [
    var.main_resource_group_name
  ]
}

# Add resource lock on web resource group
resource "azurerm_management_lock" "mentorklub_web_rg_lock" {
  name       = "DeleteLockMentorKlubWebRG"
  scope      = azurerm_resource_group.web.id
  lock_level = "CanNotDelete"
  notes      = "This lock is to prevent user deletion of the MentorKlub Web resource group"

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
  scope                = azurerm_resource_group.web.id
  role_definition_name = "Contributor"
  principal_id         = replace(data.azuread_group.mentorklub_user_group_name.id, "//groups//", "")
}

# Web App Service Plan
resource "azurerm_service_plan" "web_app_service_plan" {
  name                = "${var.main_resource_group_name}-${var.app_service_plan_name_suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.web.name
  worker_count = var.app_service_plan_worker_count

  os_type             = var.web_app_plan_os
  sku_name            = var.app_service_plan_sku
}
