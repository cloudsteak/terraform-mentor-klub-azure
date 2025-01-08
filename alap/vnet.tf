
resource "azurerm_virtual_network" "mentorklub" {
  name                = "${var.main_resource_group_name}-vnet"
  location            = azurerm_resource_group.mentorklub.location
  resource_group_name = azurerm_resource_group.mentorklub.name
  address_space       = var.vnet_address_space
  tags = {
    protected = "Yes"
    owner     = "CloudMentor"
    purpose   = "Educational"
    type      = "Permanent"
  }
}

resource "azurerm_subnet" "primary_subnet" {
  name                 = "${var.main_resource_group_name}-vnet-subnet-01"
  resource_group_name  = azurerm_resource_group.mentorklub.name
  virtual_network_name = azurerm_virtual_network.mentorklub.name
  address_prefixes     = ["${var.subnet_address_prefix}"]
}


resource "azurerm_network_security_group" "mentorklub_nsg" {
  name                = "${var.main_resource_group_name}-vnet-nsg"
  location            = azurerm_resource_group.mentorklub.location
  resource_group_name = azurerm_resource_group.mentorklub.name

  dynamic "security_rule" {

    for_each = jsondecode(file("../fajlok/security_rules.json"))
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.primary_subnet.id
  network_security_group_id = azurerm_network_security_group.mentorklub_nsg.id
}
