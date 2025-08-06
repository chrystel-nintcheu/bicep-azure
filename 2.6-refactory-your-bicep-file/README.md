# Best pratices inside a Bicep file
- [Improve paramegters and names](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/best-practices#improve-parameters-and-naming-conventions)
- [Plan the structure of your Bicep files](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/best-practices#plan-the-structure-of-your-bicep-files)  
- [Document your code by adding comments and metadata](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/best-practices#document-your-code-by-adding-comments-and-metadata) 


# Before you deploy
> You need to registre **microsoft.operationalinsights** to the current subscription. To do so:

Practically, registration should be performed using:

- Azure Portal: Go to your subscription → Resource providers → Search for "Microsoft.OperationalInsights" → Click "Register".


- Azure CLI:

```
az provider register --namespace Microsoft.OperationalInsights
```
NOTE: Registration should be handled ahead of template deployment, outside of Bicep, via CLI/PowerShell/Portal.

# Deploy

```
az deployment group create --resource-group <rg-name> --template-file main.bicep --debug
```
# Redploy in case of failure or something missing

```
az deployment group create --resource-group <rg-name> --template-file main.bicep --mode Complete --debug
```

# Destroy
```
az deployment group create --resource-group <rg-name> --template-file destroy.bicep --mode Complete --debug
```