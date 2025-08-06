param location string = resourceGroup().location

@allowed([
  'nonproduction'
  'production'
])
param envType string = 'nonproduction'

@description('The environment for which the resources are being deployed. Allowed values are: production, nonproduction.')
var envConfigMap object = {
  production: {
    appServicePLan: {
      sku: {
        name: 'S1'
        capacity: 2
      }
      storageAccount: {
        sku: {
          name: 'GRS'
        }
      }
      sqlDb: {
        sku: {
          name: 'S1'
        }
      }
    }
  }
  // Non-production environment configuration
  nonproduction: {
    appServicePLan: {
      sku: {
        name: 'F1'
        capacity: 1
      }
    }
    storageAccount: {
      sku: {
        name: 'LRS'
      }
    }
    sqlDb: {
      sku: {
        name: 'Basic'
      }
    }
  }
}

@description('A kind of unique identifier prex for each ressource created')
@minLength(3)
param sequence string = uniqueString(resourceGroup().id, 'toywebsite')

@description('The Stock Keeping Unit (SKU) for the hosting plan. Allowed values are: F1, D1, B1, B2, B3, S1, S2, S3, P1, P2, P3, P4.')
@allowed([
  'F1'
  'D1'
  'B1'
  'B2'
  'B3'
  'S1'
  'S2'
  'S3'
  'P1'
  'P2'
  'P3'
  'P4'
])
param skuHostingPlan string = envConfigMap[envType].appServicePlan.sku.name

@minValue(1)
param skuCapacity int = envConfigMap[envType].appServicePlan.sku.capacity
param sqlAdministratorLogin string

@secure()
param sqlAdministratorLoginPassword string

@description('The name of the managed identity to be created. This will be used to access the SQL database.')
param managedIdentityName string = 'managedIdentity${sequence}'

@description('The role definition ID for the SQL Database Contributor role.')
@allowed([
  'b24988ac-6180-42a0-ab88-20f7382dd24c' // SQL Database Contributor
  'f2a1a3d4-8e5b-4c6b-bd7c-9f8e1b3c5d6e' // SQL Server Contributor
])
param roleDefinitionId string = 'b24988ac-6180-42a0-ab88-20f7382dd24c'

@description('The name of the web site to be created. This will be unique within the resource group.')
@minLength(1)
@maxLength(60)
param webSiteName string = 'webSite${sequence}'

@description('The name of the container for product specifications.')
var container1Name  = 'productspecs'

@description('The name of the container for product manuals.')
param productmanualsName string = 'productmanuals'

param sqlserverName string = 'toysqlsrv${sequence}'

@description('The name of the hosting plan for the web site.')
var hostingPlanName = 'hostingplan${sequence}'
var storageAccountName = 'toystorage${sequence}'
var databaseName = 'ToyCompanyWebsite${sequence}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: 'eastus'
  sku: envConfigMap[envType].storageAccount.sku
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }

  resource blobServices 'blobServices' existing = {
    name: 'default'
  }
}
param containersList array = [
    'productspecs'
    'productmanuals'
]

/*
resource container1 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccount::blobServices
  name: container1Name
}

resource productmanuals 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccount::blobServices
  name: '${storageAccount.name}/default/${productmanualsName}'
}
*/

resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = [for (container in containersList: {
  name: container 
  parent: storageAccount::blobServices
}]

resource sqlserver 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: sqlserverName
  location: location
  properties: {
    administratorLogin: sqlAdministratorLogin
    administratorLoginPassword: sqlAdministratorLoginPassword
    version: '12.0'
  }
}

resource sqlServerNameDatabaseName 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
  name: '${sqlserver.name}/${databaseName}'
  location: location
  sku: envConfigMap[envType].sqlDb.sku
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 1073741824
  }
}

resource sqlServerNameAllowAllAzureIPs 'Microsoft.Sql/servers/firewallRules@2023-08-01-preview' = {
  name: '${sqlserver.name}/AllowAllAzureIPs'
  properties: {
    endIpAddress: '0.0.0.0'
    startIpAddress: '0.0.0.0'
  }
  dependsOn: [
    sqlserver
  ]
}


resource hostingPlan 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: hostingPlanName
  location: location
  sku: {
    name: skuHostingPlan
    capacity: skuCapacity
  }
}

resource webSite 'Microsoft.Web/sites@2023-12-01' = {
  name: webSiteName
  location: location
  properties: {
    serverFarmId: hostingPlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsightsWebSiteName.properties.InstrumentationKey
        }
        {
          name: 'StorageAccountConnectionString'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(storageAccount.id, storageAccount.apiVersion).keys[0].value}'
        }
      ]
    }
  }
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${msi.id}': {}
    }
  }
}

// We don't need this anymore. We use a managed identity to access the database instead.
//resource webSiteConnectionStrings 'Microsoft.Web/sites/config@2020-06-01' = {
//  name: '${webSite.name}/connectionstrings'
//  properties: {
//    DefaultConnection: {
//      value: 'Data Source=tcp:${sqlserver.properties.fullyQualifiedDomainName},1433;Initial Catalog=${databaseName};User Id=${sqlAdministratorLogin}@${sqlserver.properties.fullyQualifiedDomainName};Password=${sqlAdministratorLoginPassword};'
//      type: 'SQLAzure'
//    }
//  }
//}

resource msi 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-07-31-preview' = {
  name: managedIdentityName
  location: location
}

resource roleassignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: 'identityroleassignement${guid(roleDefinitionId, resourceGroup().id)}'

  properties: {
    principalType: 'ServicePrincipal'
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId)
    principalId: msi.properties.principalId
  }
}

resource appInsightsWebSiteName 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appInsights'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}
