# NetOps Deployment by examples

```
az deployment group create --resource-group <your-rg> --template-file <votre-fichier>.bicep --debug
```

# Detroy my deployment

```
az deployment group create --resource-group <your-rg> --template-file destroy-vnets.bicep --mode Complete --debug
```
[source](https://learn.microsoft.com/en-us/training/modules/build-flexible-bicep-templates-conditions-loops/6-use-loops-advanced)