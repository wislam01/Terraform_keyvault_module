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

variable "tenant_id" {
    description = "ID of the Azure AD tenant"
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
    sku_name            = "standard"
    tenant_id           = 
}

resource "azurerm_private_dns_zone" "private_dns_zones" {
    count                = length(var.environments)
    name                 = format("%s-privatelink.valtcore.azure.net", var.environments[count.index])
    resource_group_name  = azurerm_resource_group.main.name
}

resource "azurerm_private_endpoint" "private_endpoints" {
    count                            = length(var.environments)
    name                             = format("%s-keyvault-endpoint", var.environments[count.index])
    location                         = resource_group.main.location
    resource_group_name = resource_group.main.name
    subnet_id                        = "/subscription/${var.subscription_id}/resourceGroups/${var.resource_group}/providers/Microsoft.Network/virtualNetworks/my-vnet/subnets/my-subnet"
    private_service_connection {
      name                           = format("%s-keyvault-connection", var.environment[count.index])
      is_manual_connection           = false
      private_connection_resource_id = azurerm_key_vault.keyvaults[count.index].id
      subresource_names              = ["vault"]
    }
}

/* output "keyvault_ids" {
    value = azurerm_key_vault.keyvaults[*].id
} */