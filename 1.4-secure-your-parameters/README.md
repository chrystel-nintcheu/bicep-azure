# Secure your parameters
[source](https://learn.microsoft.com/en-us/training/modules/build-reusable-bicep-templates-parameters/6-exercise-create-use-parameter-files?pivots=cli)

# How to create KeyVault and store secrets with AZ CLI

```
keyVaultName='<YOUR-KEY-VAULT-NAME>'
read -s -p "Enter the login name: " login
read -s -p "Enter the password: " password

az keyvault create --resource-group <your-rg> --name $keyVaultName --location <az-region> --enabled-for-template-deployment true
az keyvault secret set --vault-name $keyVaultName --name "sqlServerAdministratorLogin" --value $login --output none
az keyvault secret set --vault-name $keyVaultName --name "sqlServerAdministratorPassword" --value $password --output none

```
> If you get the error below. 
**Forbidden) Caller is not authorized to perform action on resource.**
You need to assign permission to your keyvault

## Give your user account permissions to manage secrets in Key Vault
To gain permissions to your key vault through [Role-Based Access Control (RBAC)](https://learn.microsoft.com/en-us/azure/key-vault/general/rbac-guide?tabs=azure-cli), assign a role to your "User Principal Name" (UPN) using the Azure CLI command az role assignment create.

# HOW to assign permission ?

```
az role assignment create --role "Key Vault Secrets Officer" --assignee "<upn>" --scope "/subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.KeyVault/vaults/<your-unique-keyvault-name>"
```
# Get the key vault's ressource ID
```
az keyvault show --name $KeyVaultName --resource-group <your-rg> --query id --output tsv
```


# Deploy

```
az deployment group create --resource-group <your-rg> --name main --template-file main.bicep --parameters main.parameters.dev.json
```


# Detroy
```
z deployment group create --resource-group <your-rg> --name main --template-file destroy-main.bicep --mode Complete --debug
```
