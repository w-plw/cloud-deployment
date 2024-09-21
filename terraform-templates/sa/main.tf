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


resource "azurerm_storage_account" "example" {
  //name                     = "store777111777"
  name                     = "store${lower(random_id.example.hex)}"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

}


resource "azurerm_storage_container" "example" {
  name                  = "automate"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "example" {
  name                   = "cse.ps1"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  source_uri             = "https://raw.githubusercontent.com/w-plw/cloud-deployment/refs/heads/main/bicep-json-templates/.tests/cse.ps1"
}