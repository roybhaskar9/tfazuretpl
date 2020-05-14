provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "resourceGroup1"
  location = "West US"
}

resource "azurerm_public_ip" "example" {
  name                = "acceptanceTestPublicIp1"
  location            = "West US"
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

data "template_file" "vmip" {
  template = "${file("vmip.tpl")}"
  vars = {
    vm_ip = "${azurerm_public_ip.example.ip_address}"
  }
}
