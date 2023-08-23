output "keyvault_ids" {
  value = { for env in var.environments : env => azurerm_key_vault.keyvaults[env].id }
}

output "private_endpoint_ids" {
  value = azurerm_private_endpoint.private_endpoints
}