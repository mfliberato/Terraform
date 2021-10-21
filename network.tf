resource "azurerm_virtual_network" "matheus-vtn" {
  name                = "virtualNetwork1"
  location            = azurerm_resource_group.matheus.location
  resource_group_name = azurerm_resource_group.matheus.name
  address_space       = ["10.0.0.0/16"]
 
  tags = {
    environment = "Production"
    turma = "es22"
    faculdade = "impacta"
  }
}

resource "azurerm_subnet" "matheus-sbn" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.matheus.name
  virtual_network_name = azurerm_virtual_network.matheus-vtn.name
  address_prefixes     = ["10.0.1.0/24"]
}