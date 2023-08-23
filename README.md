# Terraform Key Vault Deployment

This Terraform configuration allows you to deploy Azure Key Vaults for different environments (e.g., prod, nonprod, dev, test, qa, perf, etc.) and make them accessible via private endpoints.

## Prerequisites

Before you begin, ensure you have the following:

- [Terraform](https://www.terraform.io/) installed on your local machine.
- An Azure subscription and authentication credentials.
- Basic understanding of Terraform and Azure concepts.

## Configuration Overview

This configuration consists of two main parts: the main module and the Key Vault sub-module.

### Main Module

The main module (`my_keyvault_module/main.tf`) sets up the following:

- Creates a resource group in the specified Azure subscription.
- Creates a virtual network (VNet) and subnet within the resource group.
- Imports the Key Vault sub-module to deploy Key Vaults with private endpoints.

### Key Vault Sub-Module

The Key Vault sub-module (`my_keyvault_module/keyvault_module`) sets up the following for each environment:

- Deploys an Azure Key Vault named `<environment>-keyvault-<random_number>` with a specified suffix.
- Registers a private DNS zone for the Key Vault.
- Creates a private endpoint for the Key Vault, connecting it to the subnet.

## How to Use

1. Clone this repository to your local machine.

2. Navigate to the `my_keyvault_module` directory:

    ```sh
    cd my_keyvault_module
    ```

3. Create Variables File: Create a terraform.tfvars file and set the following variables:
    ```hcl
    subscription_id = "your-subscription-id"
    tenant_id = "your-tenant-id"
    resource_group_name = "your-resource-group-name"
    environments = ["prod", "nonprod", "dev", "test", "qa", "perf"]
    vault_suffix = 1234  # Replace with your desired suffix
    vnet_name = "your-vnet-name"
    subnet_name = "your-subnet-name"
    ```

4. Run Terraform Commands: Run the following commands:
    ```sh
    terraform init
    terraform plan
    terraform apply
    ```

5. Review and Confirm: Review the plan output and confirm the apply action.

6. Access Key Vaults: After the deployment is complete, find the Key Vault IDs and private endpoint IDs in the Terraform output. Configure your applications to use the private endpoint URLs provided in the Terraform output to access the deployed Key Vaults.

7. Clean Up: To clean up the resources created by Terraform, run:
    ```sh
    terraform destroy
    ```

## Disclaimer
This configuration is provided as a starting point and may need adjustments to fit your specific requirements. Use it responsibly and make sure to review the configuration before applying it to your environment.

