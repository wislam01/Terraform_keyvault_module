resource "azurerm_resource_group" "main" {
    name     = var.resource_group_name
    location = "East US"
}

module "private_endpoints" {
    source = "Azure/private-endpoints/azurerm"
    resource_group_name = var.resource_group_name
    subnet_id = var.vnet_subnet_id

    private_link_service_connections = [
        for env in var.environments :
        {
            name = "${env}-keyvault"
            private_link_service_id = azurerm_key_vault.keyvaults[env].id
            is_manual_connection = false
            private_connection_resource_id = azurerm_key_vault.keyvaults[env].id
            subresource_names = ["vault"]
        }
    ]
}

resource "azurerm_key_vault" "keyvaults" {
    for_each            = tosset(var.environments)
    name                = format("%s-keyvault", each.key)
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name
    sku_name            = "standard"
}

/* resource "azurerm_private_dns_zone" "private_dns_zones" {
    count                = length(var.environments)
    name                 = format("%s-privatelink.valtcore.azure.net", var.environments[count.index])
    resource_group  = azurerm_resource_group.main.name
} */

/* resource "azurerm_private_endpoint" "private_endpoints" {
    count                            = length(var.environments)
    name                             = format("%s-keyvault-endpoint", var.environments[count.index])
    location                         = resource_group.main.location
    resource_group              = azurerm_resource_group.main.name
    subnet_id                        = "/subscription/${var.subscription_id}/resourceGroups/${var.resource_group}/providers/Microsoft.Network/virtualNetworks/my-vnet/subnets/my-subnet"
    private_service_connection {
      name                           = format("%s-keyvault-connection", var.environment[count.index])
      is_manual_connection           = false
      private_connection_resource_id = azurerm_key_vault.keyvaults[count.index].id
      subresource_names              = ["vault"]
    }
} */

output "keyvault_ids" {
    value = {for env in var.var.environments : env => azurerm_key_vault.keyvaults[env].id}
}