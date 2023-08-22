provider "azurerm" {
    features {}
    client_id       = var.client_id
    client_secret   = var.client_secret
    subscription_id = var.subscription_id
    tenant_id       = var.tenant_id
}

module "key_vaults" {
    source          = "./key_vault_module"
    environments    = var.environments
    resource_group  = var.resource_group
    subscription_id = var.subscription_id
    tenant_id       = var.tenant_id
}