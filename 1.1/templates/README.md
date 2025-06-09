# Deploy the bicep template
```
az deployment group create --name main --template-file main.bicep --parameters environmentType=nonprod
```
> Be sure you had setted the default resourceGroup previously. Otherwise:

```
az configure --defaults group="<your-rg>"
```