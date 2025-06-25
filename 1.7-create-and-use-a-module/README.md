

# Deploy the stack
```
az deployment group create --name main --template-file main.bicep --only-show-errors
```

# End the stack
```
az deployment group create --name main --template-file destroy.bicep --mode Complete --only-show-errors
```