

param location string = resourceGroup().location
param storageAccountName string = 'toyvdi${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'toyapp${uniqueString(resourceGroup().id)}'

@allowed([
  'nonprod'
  'prod'
])
param environmentType string

var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

module appService 'modules/appService.bicep' = {
  name: 'appService'
  params: {
    location: location
    appServiceAppName: appServiceAppName
    environmentType: environmentType
  }
}

/*
module appPublicIPModule 'modules/appPublicIP.bicep' = {
  name: 'appPublicIPModule'
  params: {
    customName : 'publicIP-${appServiceAppName}'
    location: location
    appServiceAppName: appServiceAppName
  }
}

*/



output appServiceAppHostName string = appService.outputs.appServiceAppHostName
//output ipAddress string = appPublicIPModule.outputs.ipAddress
//output fqdn string = appPublicIPModule.outputs.fqdn




