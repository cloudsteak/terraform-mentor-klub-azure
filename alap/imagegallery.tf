resource "azurerm_resource_group" "gallery" {
  name     = "kep-modul"
  location = var.location
  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Alap"
  }
}

resource "azurerm_shared_image_gallery" "gallery" {
  name                = "${var.main_resource_group_name}Gallery"
  location            = var.location
  resource_group_name = azurerm_resource_group.gallery.name
  description         = "Egyedei képfájlok gyűjteménye"

  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Alap"
  }
}
