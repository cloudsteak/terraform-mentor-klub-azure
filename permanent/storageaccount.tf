resource "azurerm_storage_account" "primary_sa" {
  name                     = "${var.resource_group_name}sa"
  location                 = azurerm_resource_group.mentorklub.location
  resource_group_name      = azurerm_resource_group.mentorklub.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Permanent"
  }
}
