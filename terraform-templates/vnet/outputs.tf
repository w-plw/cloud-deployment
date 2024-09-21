output "VNet_name_1" {
  description = "Vnet name"
  value       = azurerm_virtual_network.example1.name
}

output "VNet_name_2" {
  description = "Vnet name"
  value       = azurerm_virtual_network.example2.name
}