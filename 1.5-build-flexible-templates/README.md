# Build flexible Bicep templates by using conditions and loops

## What will we learn?
In this module, you'll extend a Bicep template by using conditions and loops. You'll:

- Use conditions to deploy Azure resources only when they're required.
- Use loops to deploy multiple instances of Azure resources.
- Learn how to control loop parallelism.
- Learn how to create nested loops.
- Combine loops with variables and outputs.

# Exercice

- Create a Bicep file that defines a logical server with a database.
- Add a storage account and SQL auditing settings, each of which is deployed with a condition.
- Set up an infrastructure for your development environment, and then verify the result.
- Redeploy your infrastructure against your production environment, and then look at the changes.

## HOw to set the default ressource group

```
az configure --defaults group="<your-rg>"
```
## How to set the default subcription

```
az account set --subscription <your-subscription-name>
```

# Deploy for DEV ENV

```
az deployment group create --name main --template-file main.bicep --parameters location=canadacentral
```

# Deploy for PROD ENV

```
az deployment group create --name main --template-file main.bicep --parameters environmentName=Production location=canadacentral
```

# Destroy 
```
az deployment group create --name main --template-file destroy-main.bicep --mode Complete --debug
```

[source](https://learn.microsoft.com/en-us/training/modules/build-flexible-bicep-templates-conditions-loops/3-exercise-conditions?pivots=cli)