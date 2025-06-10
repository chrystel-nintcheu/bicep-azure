# Deploy the bicep template
```
az deployment group create --name main --template-file main.bicep --parameters environmentType=nonprod
```
> Be sure you had setted the default resourceGroup previously. Otherwise:

```
az configure --defaults group="<your-rg>"
```
## Alternative way to deploy
```
az deployment group create --resource-group <your-rg> --template-file <votre-fichier>.bicep --parameters environmentType=nonprod --debug
```

# Destroy all
```
az deployment group create --resource-group <your-rg> --template-file destroy-main.bicep --mode Complete --debug
```