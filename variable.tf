variable "environments"{
    description = "List of envonments needed for the Key Vault"
    type = list(string)
}

variable "resource_group_name" {
    description = "Name of the resource group"
    type        = string
}

variable "subscription_id" {
    description = "ID of the Azure subscription"
    type = string
}