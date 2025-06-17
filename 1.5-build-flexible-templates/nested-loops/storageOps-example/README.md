# How to deploy multiple storage's accounts by example + Demo Bicep OUTPUT
```
az deployment group create --resource-group <your-rg> --template-file <votre-fichier>.bicep --debug
```

# Detroy my deployment

```
az deployment group create --resource-group <your-rg> --template-file destroy-storages.bicep --mode Complete --debug
```

[source](https://learn.microsoft.com/en-us/training/modules/build-flexible-bicep-templates-conditions-loops/7-use-loops-with-variables-and-outputs)