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

resource "azurerm_resource_group" "resourcegroup" {
  name="rg009"
  location = "West Europe"
}