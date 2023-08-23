variable "environments"{
    description = "List of envonments needed for the Key Vault"
    type        = list(string)
}

variable "resource_group_name" {
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

variable "vnet_subnet_id" {
  description = "ID of the subnet where the private endpoint will be created"
  type        = string
}