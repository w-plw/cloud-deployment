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

# Create virtual network
resource "azurerm_virtual_network" "example" {
  name                = "vm0-vnet"
  address_space       = ["10.3.0.0/16"]
  location            = var.location
  resource_group_name = var.rg_name
}

# Create subnet
resource "azurerm_subnet" "example" {
  name                 = "vm0-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.3.0.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "example" {
  name                = "vm0-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
}

# Create Network Security Group and rules
resource "azurerm_network_security_group" "example" {
  name                = "vm0-nsg"
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

# Create network interface
resource "azurerm_network_interface" "example" {
  name                = "vm0-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "vm0-nic-cfg"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.example.id
  network_security_group_id = azurerm_network_security_group.example.id
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "example" {
  name                     = "vm0store${random_id.random_id.hex}"
  location                 = var.location
  resource_group_name      = var.rg_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create virtual machine
resource "azurerm_windows_virtual_machine" "example" {
  name                  = "vm0"
  admin_username        = "azureuser"
  admin_password        = "Password1234"
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.example.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "vm0-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }


  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.example.primary_blob_endpoint
  }
}

# Install IIS web server to the virtual machine
resource "azurerm_virtual_machine_extension" "example" {
  name                       = "vm0-extension"
  virtual_machine_id         = azurerm_windows_virtual_machine.example.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.9"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools"
    }
  SETTINGS
}

# Generate random text for a unique storage account name
resource "random_id" "random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = var.rg_name
  }

  byte_length = 4
}