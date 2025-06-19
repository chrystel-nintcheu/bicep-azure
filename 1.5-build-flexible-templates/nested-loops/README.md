# Use variables and output loops

In this exercise, you'll add the virtual network and its configuration to your Bicep code, and you'll output the logical server FQDNs.

During the process, you'll:

- Update your Bicep code to specify a parameter for each virtual network's subnets.
- Add a variable loop to create a subnet array, which you'll use in the virtual network resource declaration.
- Add an output loop to create the list of logical server FQDNs.
- Deploy the Bicep file and verify the deployment.


# Deploy
```
az deployment group create --resource-group <your-rg> --template-file <votre-fichier>.bicep --debug
```

# Detroy

```
az deployment group create --resource-group <your-rg> --template-file destroy-vnets.bicep --mode Complete --debug
```


[source](https://learn.microsoft.com/en-us/training/modules/build-flexible-bicep-templates-conditions-loops/8-exercise-loops-variables-outputs?pivots=cli)