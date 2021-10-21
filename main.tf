terraform {
  required_version = ">= 0.13"

  required_providers{
      azurerm = {
          source = "hashicorp/azurerm"
          version = ">= 2.46.0"
      }
    }
}

provider "azurerm" {
  skip_provider_registration = true
  features {
    
  }
}
resource "azurerm_resource_group" "matheus" {
  name = "atividade02"
  location = "East US"
}

output "public_ip_address_mysql" {
    value = azurerm_public_ip.publicipmysqlteste.ip_address
}













