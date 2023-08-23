variable "environments"{
    description = "List of envonments needed for the Key Vault"
    type        = list(string)
}

variable "resource_group" {
    description = "Name of the resource group"
    type        = string
}
