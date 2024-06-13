terraform {
  required_providers {
    azurerm={
        source = "hashicorp/azurerm"
        version = "3.107.0"
    }
  }
}

provider "azurerm" {
  features{}  
}

resource "azurerm_virtual_network" "virtualnetwork1" {
  name="VN1"
  resource_group_name = "rg009"
  location = "West Europe"
  address_space = ["10.0.0.0/16"]
}