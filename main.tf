variable "environments" {
  description = "List of the environments for where to create the Key Vault"
  type        = list(string)

}

variable "resource.group_name" {
  description = "Name of the Resource Group"
  type        = string

}

variable "azurerm_resource_group" "main" {
  name     = "var.resource_group_name"
  Location =  "East US"

}
