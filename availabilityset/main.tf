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
    key="avset.tfstate"
  }
}

provider "azurerm" {
  features{}  
}
locals {
  virtual_network_name="VN1"
  location="West Europe"
  resource_group_name="rg009"
  platform_update_domain_count = 6
    platform_fault_domain_count = 2
}
resource "azurerm_availability_set" "AVSET1" {
    name                       = "availset1"
  resource_group_name          = local.resource_group_name
  location                     = local.location
  platform_update_domain_count = local.platform_update_domain_count
  platform_fault_domain_count  = local.platform_fault_domain_count
}