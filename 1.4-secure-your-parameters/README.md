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

### Deploy

```
az deployment group create --resource-group <your-rg> --name main --template-file main.bicep --parameters main.parameters.dev.json
```


