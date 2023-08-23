variable "client_id" {
  description = "Client ID of the Azure service principal"
  type        = string
}

variable "client_secret" {
  description = "Client secret of the Azure service principal"
  type        = string
}

variable "environments"{
    description = "List of envonments needed for the Key Vault"
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

variable "tenant_id" {
    description = "ID of the Azure AD tenant"
    type        = string
}