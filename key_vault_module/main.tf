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
    name     = var.resource_group
    location = "East US"
}

resource "azurerm_key_vault" "keyvaults" {
    count               = length(var.environments)
    name                = format("%s-keyvault", var.environments[count.index])
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_private_dns_zone" "private_dns_zones" {
    count                = length(var.environments)
    name                 = format("%s-privatelink.valtcore.azure.net", var.environments[count.index])
    resource_group_name  = azurerm_resource_group.main.name
    registration_enabled = true
}

resource "azurerm_private_endpoint" "private_endpoints" {
    count = 
    name = 
    location = 
    resource_group_name = 
    subnet_id = 
    private_service_connection {
      name = 
      is_manual_connection = 
      private_connection_resource_id = 
      subresource_names = 
    }
}

output "keyvault_ids" {
    value = azurerm_key_vault.keyvaults[*].id
}