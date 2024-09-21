import {
  to = azurerm_resource_group.example
  id = var.rg_id
}


resource "random_id" "example" {
  byte_length = 4
}


resource "azurerm_resource_group" "example" {
  name     = var.rg_name
  location = var.location

  tags = {
    CreationTime = var.creation_time
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to the 'tags' attribute
      tags,
    ]
  }
}

// vnet-01 set
resource "azurerm_virtual_network" "example1" {
  name                = "vnet01"
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "example11" {
  name                 = "subnet01"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.example1.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_network_interface" "example11" {
  name                = "vnet01-sub01-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example11.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "example11" {
  name                = "vnet01-sub01-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_subnet" "example12" {
  name                 = "subnet02"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.example1.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_network_interface" "example12" {
  name                = "vnet01-sub02-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example12.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "example12" {
  name                = "vnet01-sub02-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
}


// vnet-02 set
resource "azurerm_virtual_network" "example2" {
  name                = "vnet02"
  address_space       = ["10.2.0.0/16"]
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "example21" {
  name                 = "subnet01"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.example2.name
  address_prefixes     = ["10.2.1.0/24"]
}

resource "azurerm_network_interface" "example21" {
  name                = "vnet02-sub01-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example21.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "example21" {
  name                = "vnet02-sub01-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
}


resource "azurerm_subnet" "example22" {
  name                 = "subnet02"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.example2.name
  address_prefixes     = ["10.2.2.0/24"]
}

resource "azurerm_network_interface" "example22" {
  name                = "vnet02-sub02-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example22.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "example22" {
  name                = "vnet02-sub02-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
}