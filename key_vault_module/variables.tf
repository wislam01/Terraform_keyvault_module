variable "environments"{
    description = "List of envonments needed for the Key Vault"
    type        = list(string)
}

variable "resource_group_name" {
    description = "Name of the resource group"
    type        = string
}

variable "vnet_subnet_id" {
    description = "ID of the subnet where the private endpoing will be created"
    type        = string
}
