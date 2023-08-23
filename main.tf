terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "=0.1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.2"
    }
  }
}

provider "azurerm" {
    features {}
    subscription_id = var.subscription_id
    tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = "East US"
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "random_integer" "vault_suffix" {
  min = 100
  max = 999
}

module "keyvaults" {
    source               = "./key_vault_module"
    environments         = var.environments
    resource_group_name  = var.resource_group_name
    vnet_subnet_id       = azurerm_subnet.subnet.id
    tenant_id            = var.tenant_id
    vault_suffix         = random_integer.vault_suffix.result
}
