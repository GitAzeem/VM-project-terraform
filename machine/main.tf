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
    key="machine.tfstate"
  }
}
provider "azurerm" {
  features{}  
}

data "azurerm_network_interface" "NIC1ID" {
  name="network-interface-1"
  resource_group_name = local.resource_group_name
  }

data "azurerm_network_interface" "NIC2ID" {
  name="network-interface-2"
  resource_group_name = local.resource_group_name
  }

data "terraform_remote_state" "avsetid" {
  backend="azurerm"


  config = {
     resource_group_name = "rg009"
    storage_account_name = "vmproject001"
    container_name = "vmproject"
    key="avset.tfstate"
  }

  
}



locals {
  virtual_network_name="VN1"
  location="West Europe"
  resource_group_name="rg009"
  size="Standard_F2"
}








resource "azurerm_windows_virtual_machine" "VM1" {
  name                = "pro-vm1"
  resource_group_name = local.resource_group_name
  location            = local.location
  size                = local.size
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  availability_set_id = data.terraform_remote_state.avsetid.outputs.avsetID
  network_interface_ids = [data.azurerm_network_interface.NIC1ID.id
    
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}



resource "azurerm_windows_virtual_machine" "VM2" {
  name                = "pro-vm2"
  resource_group_name = local.resource_group_name
  location            = local.location
  size                = local.size
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  availability_set_id = data.terraform_remote_state.avsetid.outputs.avsetID
  network_interface_ids = [data.azurerm_network_interface.NIC2ID.id
    
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}