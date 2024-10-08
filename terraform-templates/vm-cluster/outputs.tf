output "resource_group_name" {
  value = azurerm_resource_group.example.name
}

output "public_ip_address" {
  value = azurerm_windows_virtual_machine.main.public_ip_address
}

output "admin_username" {
  sensitive = true
  value     = azurerm_windows_virtual_machine.main.admin_password
}

output "admin_password" {
  sensitive = true
  value     = azurerm_windows_virtual_machine.main.admin_password
}