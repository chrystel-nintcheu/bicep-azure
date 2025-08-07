# Preview changes with the what-if command

[source](https://learn.microsoft.com/en-us/training/modules/arm-template-whatif/4-exercise-what-if?tabs=screenshpt&pivots=bicepcli)

# Display subscription list

```
az account list --refresh --output table
```
# Apply filter based on subscription name

```
az account list --refresh --query "[?contains(name, '{your subscription name}')].id" --output table
```
# Set default subscription 

```
az account set --subscription {your subscription ID}
```

# Get list of ressource group

```
az group list --output table
```

# Search for a resource group based on keyword

az group list --query "[?contains(name, '{keyword}')]" --output table

# Set default resource group for the current user

```
az configure --defaults group="{your resource group name}"
```

# Apply what-if command after modified your template file

```
az deployment group what-if --template-file main.bicep
```

# Apply confirm-with-what-if command to avoid big mistake in production

```
az deployment group create --name main --mode Complete --confirm-with-what-if --template-file main.bicep
```