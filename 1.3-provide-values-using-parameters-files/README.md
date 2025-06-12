# Secure your parameters
[source](https://learn.microsoft.com/en-us/training/modules/build-reusable-bicep-templates-parameters/5-how-secure-parameter)

# Exercice: Add a parameter file and secure parameters
[source](https://learn.microsoft.com/en-us/training/modules/build-reusable-bicep-templates-parameters/6-exercise-create-use-parameter-files?pivots=powershell)

## Exercice Purpose
- Add some secure parameters.
- Create a parameters file.
- Test the deployment to ensure that the parameters file is valid.
- Create a key vault and secrets.
- Update the parameters file to refer to the key vault secrets.
- Re-test the deployment to ensure that the parameters file is still valid.

### Deploy

```
az deployment group create --resource-group <your-rg> --name main --template-file main.bicep --parameters main.parameters.dev.json
```

# How to create a new resource group

```
az group create --name <your-rg-name> --location <az-region> --subscription <your-subscription> --debug
```
# List of available regions 

```
australiacentral,australiaeast,australiasoutheast,brazilsouth,canadacentral,canadaeast,centralindia,centralus,eastasia,eastus2,eastus,francecentral,germanywestcentral,japaneast,japanwest,jioindiawest,koreacentral,koreasouth,northcentralus,northeurope,norwayeast,southafricanorth,southcentralus,southindia,southeastasia,swedencentral,switzerlandnorth,uaenorth,uksouth,ukwest,westcentralus,westeurope,westindia,westus2,westus3,westus,qatarcentral,israelcentral,polandcentral,italynorth,spaincentral,mexicocentral,chilecentral,malaysiawest,newzealandnorth,indonesiacentral,australiacentral2.

```



# Show all resource group available

```
az group list --output table
```

# How to delete a resource group

```
az group delete --name <your-rg>
```
