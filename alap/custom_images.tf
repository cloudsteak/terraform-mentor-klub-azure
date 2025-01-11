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


# Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "image-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.gallery.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "/subscriptions/${var.subscription_id}/resourceGroups/${var.main_resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.main_resource_group_name}-vnet/subnets/${var.main_resource_group_name}-vnet-subnet-01"
    private_ip_address_allocation = "Dynamic"
  }
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "image-vm"
  location                        = var.location
  resource_group_name             = azurerm_resource_group.gallery.name
  size                            = "Standard_B1s"
  disable_password_authentication = false
  admin_username                  = "rendszergazda"
  admin_password                  = "Ab123456789!"

  network_interface_ids = [azurerm_network_interface.nic.id]

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
}

# Storage Container for storing scripts
resource "azurerm_storage_container" "script_container" {
  name                  = "scripts"
  storage_account_id    = azurerm_storage_account.primary_sa.id
  container_access_type = "blob"
}

# Upload mentor.sh
resource "azurerm_storage_blob" "mentor_sh" {
  name                   = "mentor.sh"
  storage_account_name   = azurerm_storage_account.primary_sa.name
  storage_container_name = azurerm_storage_container.script_container.name
  type                   = "Block"
  source                 = "../scripts/mentor.sh"
}

# Upload mentor.service
resource "azurerm_storage_blob" "mentor_service" {
  name                   = "mentor.service"
  storage_account_name   = azurerm_storage_account.primary_sa.name
  storage_container_name = azurerm_storage_container.script_container.name
  type                   = "Block"
  source                 = "../scripts/mentor.service"
}

# Upload mentor_install.sh
resource "azurerm_storage_blob" "mentor_install_sh" {
  name                   = "mentor_install.sh"
  storage_account_name   = azurerm_storage_account.primary_sa.name
  storage_container_name = azurerm_storage_container.script_container.name
  type                   = "Block"
  source                 = "../scripts/mentor_install.sh"
}

resource "azurerm_virtual_machine_extension" "custom_script" {
  name                 = "CustomScript"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
  {
    "fileUris": [
      "${azurerm_storage_blob.mentor_sh.url}",
      "${azurerm_storage_blob.mentor_service.url}",
      "${azurerm_storage_blob.mentor_install_sh.url}"
    ],
    "commandToExecute": "bash -c 'chmod +x mentor_install.sh && ./mentor_install.sh'"
  }
  SETTINGS
}

# Stop the VM
resource "null_resource" "stop_vm" {
  provisioner "local-exec" {
    command = "az vm stop --resource-group ${azurerm_resource_group.gallery.name} --name ${azurerm_linux_virtual_machine.vm.name}"
  }
  depends_on = [azurerm_virtual_machine_extension.custom_script]
}


# Generalize the VM
resource "null_resource" "generalize_vm" {
  provisioner "local-exec" {
    command = "az vm generalize --resource-group ${azurerm_resource_group.gallery.name} --name ${azurerm_linux_virtual_machine.vm.name}"
  }
  depends_on = [null_resource.stop_vm]
}

# Create a custom image from the VM
resource "azurerm_image" "custom_image" {
  name                      = "${formatdate("YYYY.MM.DD", timestamp())}-image"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.gallery.name
  source_virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  hyper_v_generation = "V2"
}

resource "azurerm_shared_image" "shared_image" {
  name                = "Ubuntu22-Apache2-TesztOldal"
  gallery_name        = azurerm_shared_image_gallery.gallery.name
  location            = var.location
  resource_group_name = azurerm_resource_group.gallery.name
  os_type             = "Linux"
  description         = "Shared image from custom image"


  identifier {
    publisher = "CloudMentor"
    offer     = "0001-hu-mentorklub-ubuntu-webserver-apache2"
    sku       = "22.04"
  }

  hyper_v_generation = "V2"

  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Alap"
  }


}

resource "azurerm_shared_image_version" "image_version" {
  name                = formatdate("YYYY.MM.DD", timestamp())
  gallery_name        = azurerm_shared_image_gallery.gallery.name
  image_name          = azurerm_shared_image.shared_image.name
  managed_image_id    = azurerm_image.custom_image.id
  resource_group_name = azurerm_shared_image.shared_image.resource_group_name
  location            = var.location


  target_region {
    name                   = var.location
    regional_replica_count = 1
    storage_account_type   = "Standard_LRS"
  }

  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Alap"
    version   = formatdate("YYYY.MM.DD", timestamp())
  }
}


resource "null_resource" "delete_custom_image" {
  provisioner "local-exec" {
    command = "terraform destroy -target azurerm_image.custom_image -auto-approve"
  }

  depends_on = [azurerm_shared_image.shared_image]
}
