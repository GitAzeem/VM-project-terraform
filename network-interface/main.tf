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
    key="NIC.tfstate"
  }
}

provider "azurerm" {
  features{}  
}

data "terraform_remote_state" "subnetid" {
  backend = "azurerm"
  config = {
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

resource "azurerm_network_interface" "NIC1" {
  name="network-interface-1"
  location = local.location
  resource_group_name = local.resource_group_name
  ip_configuration {
    name="internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id = data.terraform_remote_state.subnetid.outputs.DEV-id
  }
}


resource "azurerm_network_interface" "NIC2" {
  name="network-interface-2"
  location = local.location
  resource_group_name = local.resource_group_name
  ip_configuration {
    name="internal"
    private_ip_address_allocation="Dynamic"
    subnet_id = data.terraform_remote_state.subnetid.outputs.PROD-id
  }
}