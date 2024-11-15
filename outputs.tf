output "resource_group_names" {
  value = azurerm_resource_group.example[*].name
}

output "storage_account_names" {
  value = azurerm_storage_account.example[*].name
}
