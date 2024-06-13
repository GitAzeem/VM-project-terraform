terraform {
  required_providers {
    azurerm={
        source = "hashicorp/azurerm"
        version = "3.107.0"
    }
  }

  backend "azurerm" {
    resource_group_name = "rg009"
    storage_account_name = "vmproject001"
    container_name = "vmproject"
    key="subnet.tfstate"
  }


}

locals {
  virtual_network_name="VN1"
  location="West Europe"
  resource_group_name="rg009"
}

provider "azurerm" {
  features{}  
}


resource "azurerm_subnet" "subnet1" {
  name="DEV"
  virtual_network_name = local.virtual_network_name
  resource_group_name = local.resource_group_name
  address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet2" {
  name="PROD"
  virtual_network_name = local.virtual_network_name
  resource_group_name = local.resource_group_name
  address_prefixes = ["10.0.2.0/24"]
}