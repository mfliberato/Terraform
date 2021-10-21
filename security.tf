resource "azurerm_network_security_group" "matheus-security" {
  name                = "security-firewall"
  location            = azurerm_resource_group.matheus.location
  resource_group_name = azurerm_resource_group.matheus.name

  security_rule {
        name                       = "mysql"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3306"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
  }
  
  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_interface_security_group_association" "matheus-association" {
  network_interface_id      = azurerm_network_interface.matheus-interface.id
  network_security_group_id = azurerm_network_security_group.matheus-security.id
}
