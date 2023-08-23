provider "azurerm" {
    features {}
    subscription_id = var.subscription_id
    tenant_id       = var.tenant_id
}

module "keyvaults" {
    source               = "./key_vault_module"
    environments         = var.environments
    resource_group       = var.resource_group_name
    vnet_subnet_id       = var.vnet_subnet_id
}
