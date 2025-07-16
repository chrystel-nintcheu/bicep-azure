@description('Nom de l’IP publique')
param publicIpName string = 'myPublicIp-${uniqueString(resourceGroup().id)}'

resource publicIp 'Microsoft.Network/publicIPAddresses@2023-09-01' = {
  name: publicIpName
  location: resourceGroup().location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    sku: {
      name: 'Basic'
    }
  }
}

output publicIpId string = publicIp.id
output publicIpName string = publicIp.name
