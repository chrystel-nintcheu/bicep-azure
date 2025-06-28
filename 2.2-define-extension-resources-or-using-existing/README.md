# Create a Log Analytics workspace
```
az monitor log-analytics workspace create --workspace-name ToyLogs --location eastus -g learn-3b3a2102-6496-4e66-8458-6f102dc4f787
```

# Create a storage account for toy design documents
````
 az storage account create --name storageaccount20250628 --location eastus
```

```
storageaccountYYYYMMdd
```

# Destroy
```
az deployment group create --name destroy-main --template-file destroy.bicep --mode Complete
```


[source](https://learn.microsoft.com/en-us/training/modules/child-extension-bicep-templates/7-exercise-deploy-extension-existing-resources?pivots=cli)
