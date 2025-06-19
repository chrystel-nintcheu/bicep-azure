In this module, you'll extend a Bicep template by using conditions and loops. You'll:

Use conditions to deploy Azure resources only when they're required.
Use loops to deploy multiple instances of Azure resources.
Learn how to control loop parallelism.
Learn how to create nested loops.
Combine loops with variables and outputs



# Deploy DEV

```
az deployment group create --resource-group <your-rg> --name main --template-file main.bicep --debug
```

# Deploy PROD

```
az deployment group create --name main --template-file main.bicep --parameters environmentName=Production location=westus3 --debug
```


# Destroy

```
az deployment group create --resource-group <your-rg> --name main --template-file destroy-main.bicep --mode Complete --debug
```


[source](https://learn.microsoft.com/en-us/training/modules/build-flexible-bicep-templates-conditions-loops/3-exercise-conditions?pivots=cli)

