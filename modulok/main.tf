resource "azurerm_resource_group" "mentorklub" {
  name     = var.main_resource_group_name
  location = var.location
  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Modulok"
  }
}
