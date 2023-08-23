variable "tenant_id" {
  description = "ID of the Azure AD tenant"
  type        = string
}

variable "vault_suffix" {
  description = "Random number to append to Key Vault names"
  type        = number
}

resource "azurerm_resource_group" "main" {
    name     = var.resource_group_name
    location = "East US"
}

resource "azurerm_key_vault" "keyvaults" {
    for_each            = toset(var.environments)
    name                = format("%s-keyvault-%04d", each.key, var.vault_suffix)
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name
    sku_name            = "standard"
    tenant_id           = var.tenant_id
}

resource "azurerm_private_dns_zone" "private_dns_zones" {
    for_each = azurerm_key_vault.keyvaults
    name                 = "${each.key}-privatelink.vaultcore.azure.net"
    resource_group_name  = azurerm_resource_group.main.name
    #registration_enabled = true
}

resource "azurerm_private_endpoint" "private_endpoints" {
    for_each                 = azurerm_key_vault.keyvaults
    name                     = "${each.key}-keyvault-endpoint"
    location                 = azurerm_resource_group.main.location
    resource_group_name           = azurerm_resource_group.main.name
    subnet_id                = var.vnet_subnet_id
    private_dns_zone_group {
      name                   = "${each.key}-pdzg"
      private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zones[each.key].id]
      #private_dns_zone_group = [azurerm_private_dns_zone.private_dns_zones[each.key].id]
    }

    private_service_connection {
      name                           = "${each.key}-kv-conn"
      is_manual_connection           = false
      private_connection_resource_id = azurerm_key_vault.keyvaults[each.key].id
      subresource_names              = ["vault"]
    }
}

