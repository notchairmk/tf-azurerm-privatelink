locals {
  vnet_cidr = "10.0.0.0/16"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = [local.vnet_cidr]
}

resource "azurerm_subnet" "primary" {
  name                 = "primary"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(local.vnet_cidr, 8, 0)]
}

resource "azurerm_subnet" "private_link" {
  name                 = "privatelink"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(local.vnet_cidr, 8, 1)]

  enforce_private_link_endpoint_network_policies = true
}
