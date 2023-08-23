output "keyvault_ids" {
    value = {for env in var.var.environments : env => azurerm_key_vault.keyvaults[env].id}
}