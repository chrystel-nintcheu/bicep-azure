# What is the main goal?
By the end of this module, you'll be able to:

- Customize parameters and limit the values that can be used by each parameter
- Understand the ways that parameters can be passed to a Bicep template
- Work with secure parameters to ensure that secrets aren't leaked or shared unnecessarily

# Deploy
## Option 1: in two commands
```
az configure --defaults group="<your-rg>"
```

Then

```
az deployment group create --name main --template-file main.bicep
```

## Option 2 : in a single command
```
az deployment group create --resource-group <your-rg> --name main --template-file main.bicep
```

# Check your deployments
You can also verify the deployment from the command line. To do so, run the following Azure CLI command:

```
az deployment group list --output table
```

# Delete your deployment

```
az deployment group create --resource-group <your-rg> --name main  --mode Complete --template-file destroy-main.bicep
```

[source](https://learn.microsoft.com/en-us/training/modules/build-reusable-bicep-templates-parameters/3-exercise-add-parameters-with-decorators?pivots=cli)