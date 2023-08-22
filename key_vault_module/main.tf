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