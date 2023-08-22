provider "azurerm" {
    features {}
}

module "key_vaults" {
    source          = "./key_vault_module"

    environments    = ["prod", "nonprod", "dev", "test", "qa", "perf"]
    resource_group  = "keyvaults_rg" # Replace with desired resource group name
    subscription_id = "**********" # Replace with own subscription ID
}

output "retrieved_keyvault_ids" {
    value = module.key_vaults.keyvault_ids
}