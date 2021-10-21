resource "azurerm_network_interface" "matheus-interface" {
  name                = "interface"
  location            = azurerm_resource_group.matheus.location
  resource_group_name = azurerm_resource_group.matheus.name

  ip_configuration {
    name                          = "interface-matheus"
    subnet_id                     = azurerm_subnet.matheus-sbn.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.matheus-ip.id
  }
}