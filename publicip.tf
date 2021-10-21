resource "azurerm_public_ip" "matheus-ip" {
  name                = "public-ip1"
  resource_group_name = azurerm_resource_group.matheus.name
  location            = azurerm_resource_group.matheus.location
  allocation_method = "Static"
  
    tags = {
    environment = "Production"
  }
}

