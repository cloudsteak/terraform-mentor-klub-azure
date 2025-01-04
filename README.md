# IaC projekt a Mentor Klub Azure erőforrásainak létrehozására

## Előkészületek

1. Service Principal létrehozása

    Az Azure erőforrások létrehozásához szükségünk van egy Service Principal-ra, amelynek azonosítója és jelszava alapján tudunk az Azure API-ján keresztül kommunikálni. A Service Principal létrehozásához szükségünk van az Azure CLI-re, amelyet a [Microsoft hivatalos dokumentációja](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) alapján tudunk telepíteni.

    A Service Principal létrehozásához a következő parancsot kell futtatni az Azure CLI-ből:

    ```bash
    az ad sp create-for-rbac --name "<app name>" --role contributor --scopes "/subscriptions/<subcription id>" --sdk-auth
    ```

    A parancs visszaadja a Service Principal azonosítóját és jelszavát, amelyeket a későbbiekben felhasználunk.

2. Service Principal a GitHub Secrets-ben

    A Service Principal azonosítóját és jelszavát, az előfizetés és a tenant azonosítóját a GitHub Secrets-ben tároljuk, hogy a GitHub Actions használhassa azokat az Azure erőforrások létrehozásához. A GitHub Secrets-ben a következő kulcsot kell létrehozni: `AZURE_CREDENTIALS`, melynek értéke az alábbi formátumú JSON objektum: 
    
    ```json
    {
      "clientId": "...",
      "clientSecret": "...",
      "subscriptionId": "<subcription id>",
      "tenantId": "...",
    }
    ```

3. Azure Resource Group és Storage Account létrehozása

    Az Azure erőforrások létrehozásához szükségünk van egy Resource Group-ra és egy Storage Account-ra, amelyeket a következő parancsokkal tudunk létrehozni az Azure CLI-ből:

    ```bash
    #!/bin/bash

    RESOURCE_GROUP_NAME=tfstate
    STORAGE_ACCOUNT_NAME=tfstate$RANDOM
    CONTAINER_NAME=tfstate

    # Create resource group
    az group create --name $RESOURCE_GROUP_NAME --location swedencentral

    # Create storage account
    az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

    # Create blob container
    az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME
    ```

    A Storage Account kulcsait a következő parancs segítségével tudjuk lekérni:

    ```bash
    ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
    export ARM_ACCESS_KEY=$ACCOUNT_KEY
    ```

## Backend konfiguráció

A Terraform állapotát a Storage Account-ban tároljuk, amelyhez a következő backend konfigurációt kell megadni a `backend.tf` fájlban:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name   = "tfstate"
    storage_account_name  = "tfstate12345"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}
```


