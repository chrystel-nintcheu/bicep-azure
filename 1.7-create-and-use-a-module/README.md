

# Deploy the stack
```
az deployment group create --name main --template-file main.bicep --only-show-errors
```

# End the stack
```
az deployment group create --name main --template-file destroy.bicep --mode Complete --only-show-errors
```

[source](https://learn.microsoft.com/en-us/training/modules/create-composable-bicep-files-using-modules/4-exercise-create-use-module?pivots=cli)