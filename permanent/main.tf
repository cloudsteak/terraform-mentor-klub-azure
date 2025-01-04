resource "azurerm_resource_group" "mentorklub" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Permanent"
  }
}

