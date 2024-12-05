variable "location" {
  description = "Azure location for the resources"
  type        = string
  default     = "East US"
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  count    = 10
  name     = "example-resource-group-${count.index}"
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  count                    = 20
  name                     = "examplestorage${count.index}"
  resource_group_name      = azurerm_resource_group.example[count.index % 10].name
  location                 = azurerm_resource_group.example[count.index % 10].location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_virtual_network" "example" {
  count     = 5
  name      = "example-vnet-${count.index}"
  location  = azurerm_resource_group.example[0].location
  address_space = ["10.0.${count.index}.0/24"]
  resource_group_name = azurerm_resource_group.example[count.index % 10].name
}
