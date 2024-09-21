import {
  to = azurerm_resource_group.example
  id = var.rg_id
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

### Create vnet01 set
resource "azurerm_virtual_network" "example1" {
  name                = "vnet01"
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = var.rg_name
}


## Create vnet01 subnet01 set
resource "azurerm_subnet" "example11" {
  name                 = "subnet01"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.example1.name
  address_prefixes     = ["10.1.1.0/24"]
}

# Create network interface
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

# Create public IPs
resource "azurerm_public_ip" "example11" {
  name                = "vnet01-sub01-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
}

# Create Network Security Group and rules
resource "azurerm_network_security_group" "example11" {
  name                = "vnet01-sub01-nsg"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "web"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example11" {
  network_interface_id      = azurerm_network_interface.example11.id
  network_security_group_id = azurerm_network_security_group.example11.id
}

## Create vnet01 subnet02 set
resource "azurerm_subnet" "example12" {
  name                 = "subnet02"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.example1.name
  address_prefixes     = ["10.1.2.0/24"]
}

# Create network interface
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

# Create public IPs
resource "azurerm_public_ip" "example12" {
  name                = "vnet01-sub02-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
}

# Create Network Security Group and rules
resource "azurerm_network_security_group" "example12" {
  name                = "vnet01-sub02-nsg"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "web"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example12" {
  network_interface_id      = azurerm_network_interface.example12.id
  network_security_group_id = azurerm_network_security_group.example12.id
}


### Create vnet02 set
resource "azurerm_virtual_network" "example2" {
  name                = "vnet02"
  address_space       = ["10.2.0.0/16"]
  location            = var.location
  resource_group_name = var.rg_name
}

## Create vnet02 subnet01 set
resource "azurerm_subnet" "example21" {
  name                 = "subnet01"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.example2.name
  address_prefixes     = ["10.2.1.0/24"]
}

# Create network interface
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

# Create public IPs
resource "azurerm_public_ip" "example21" {
  name                = "vnet02-sub01-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
}

# Create Network Security Group and rules
resource "azurerm_network_security_group" "example21" {
  name                = "vnet02-sub01-nsg"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "web"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example21" {
  network_interface_id      = azurerm_network_interface.example21.id
  network_security_group_id = azurerm_network_security_group.example21.id
}


## Create vnet02 subnet02 set
resource "azurerm_subnet" "example22" {
  name                 = "subnet02"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.example2.name
  address_prefixes     = ["10.2.2.0/24"]
}

# Create network interface
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

# Create public IPs
resource "azurerm_public_ip" "example22" {
  name                = "vnet02-sub02-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
}

# Create Network Security Group and rules
resource "azurerm_network_security_group" "example22" {
  name                = "vnet02-sub02-nsg"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "web"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example22" {
  network_interface_id      = azurerm_network_interface.example22.id
  network_security_group_id = azurerm_network_security_group.example22.id
}