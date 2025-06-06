# Deploy the bicep template
```
az deployment group create --name main --template-file main.bicep --parameters environmentType=nonprod
```
> Be sure you already have set the default resourceGroup. Otherwise:

```
az configure --defaults group="<your-rg>"
```