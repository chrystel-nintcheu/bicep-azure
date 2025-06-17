# NetOps Deployment example

```
az deployment group create --resource-group <your-rg> --template-file <votre-fichier>.bicep --debug
```

# Detroy my deployment

```
az deployment group create --resource-group <your-rg> --template-file destroy-vnets.bicep --mode Complete --debug
```
