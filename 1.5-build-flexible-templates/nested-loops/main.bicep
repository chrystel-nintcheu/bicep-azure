@description('The Azure regions into which the resources should be deployed.')
param locations array = [
  'canadacentral'
  'eastus2'
  'eastasia'
]

@secure()
@description('The administrator login username for the SQL server.')
param sqlServerAdministratorLogin string

@secure()
@description('The administrator login password for the SQL server.')
param sqlServerAdministratorLoginPassword string

/*
@description('The IP address range for all virtual networks to use.')
param virtualNetworkAddressPrefix string = '10.10.0.0/16'
*/

@description('The name and IP address range for each subnet in the virtual networks.')
param subnets array = [
  {
    name: 'frontend'
   //ipAddressRange: '10.10.5.0/24'
  }
  {
    name: 'backend'
    //ipAddressRange: '10.10.10.0/24'
  }
]
/*
var subnetProperties = [for subnet in subnets: {
  name: subnet.name
  properties: {
    addressPrefix: subnet.ipAddressRange
  }
}]
  
*/

module databases 'modules/database.bicep' = [for location in locations: {
  name: 'database-${location}'
  params: {
    location: location
    sqlServerAdministratorLogin: sqlServerAdministratorLogin
    sqlServerAdministratorLoginPassword: sqlServerAdministratorLoginPassword
  }
}]

/*
resource virtualNetworks 'Microsoft.Network/virtualNetworks@2024-05-01' = [for location in locations: {
  name: 'teddybear-${location}'
  location: location
  properties:{
    addressSpace:{
      addressPrefixes:[
        virtualNetworkAddressPrefix
      ]
    }
    subnets: subnetProperties
  }
}]

*/

resource virtualNetworks 'Microsoft.Network/virtualNetworks@2024-05-01' = [for (location, l) in locations: {
  name: 'vnet-${location}'
  location: location
  properties:{
    addressSpace:{
      addressPrefixes:[
        '10.${l}.0.0/16'
      ]
    }
    subnets: [for j in range(1, length(subnets)): {
      name: 'subnet-${location}-${subnets[j - 1].name}'
      properties: {
        addressPrefix: '10.${l}.${j}.0/24'
      }
    }]
  }
}]



output serverInfo array = [for i in range(0, length(locations)): {
  name: databases[i].outputs.serverName
  location: databases[i].outputs.location
  fullyQualifiedDomainName: databases[i].outputs.serverFullyQualifiedDomainName
}]
