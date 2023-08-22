variable "environments" {
    description = "List of environments for the key vaults"
    type        = list(string)
}

variable "resource_group" {
    description = "Name of the resource group"
    type        = string
}

variable "subscription_id" {
    description = "ID of the Azure subscription"
    type        = string
}

resource "azurerm_resource_group" "main" {
    name = var.resource_group
    location = "East US"
}

resource "azurerm_key_vault" "keyvaults" {
    count               = length(var.environments)
    name                = 
    location            = azurerm_resource_group.main.location
    resource_group_name = var.resource_group
}

resource "azure_private_dns_zone" "private_dns_zones" {

}

resource "azure_private_endpoint" "private_endpoints" {

}

output "keyvault_ids" {
    value = azurerm_key_vault.keyvaults[*].id
}