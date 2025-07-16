@description('Nom de l’interface réseau')
param nicName string = 'nicName-${uniqueString(resourceGroup().id)}'

@description('ID du subnet')
param subnetId string

@description('ID de l’IP publique')
param publicIpId string

@description('ID du NSG (optionnel)')
param nsgId string

resource nic 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: nicName
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnetId
          }
          publicIPAddress: {
            id: publicIpId
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsgId
    }
  }
}

output nicId string = nic.id
output nicName string = nic.name
