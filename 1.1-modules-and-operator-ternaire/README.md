# How to navigate between azure subscriptions with az cli

If you've used more than one sandbox recently, the terminal might display more than one instance of Concierge Subscription. In this case, use the next two steps to set one as the default subscription.

**a.Get the Concierge Subscription IDs.**
```
az account list --refresh --output table
az account list --refresh --query "[?contains(name, 'Concierge Subscription')].id" --output table
```
**b.Set the default subscription by using the subscription ID. Replace {your subscription ID} with the latest Concierge Subscription ID.**
```
az account set --subscription {your subscription ID}
```
# Set the default resource group
When you use the Azure CLI, you can set the default resource group and omit the parameter from the rest of the Azure CLI commands in this exercise. Set the default to the resource group that's created for you in the sandbox environment.

```
az configure --defaults group="<your-rg>"
```

You can also verify the deployment from the command line. To do so, run the following Azure CLI command:
```
az deployment group list --output table
```