variable "environments" {
    description = "List of environments to make the key vault for"
    type        = list(string)
}

variable "resource_group"{

}

variable "subscription_id" {

}

resource "azurerm_key_vault" "keyvaults" {

}

resource "azurerm_private_dns_zone" "private_dns_zones" {

}

resource "azurerm_private_endpoint" "private_endpoints" {
    
}