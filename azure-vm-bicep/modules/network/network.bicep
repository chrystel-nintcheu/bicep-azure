@description('Nom du réseau virtual (VNet)')
param vnetName string = 'vnetlabel'

@description('Préfixe par defaut plage addresse VNet')
//param vnetAddressPrefix string = '10.0.0.0/16'
param vnetAddressPrefix string

@description('Préfixe par default plage addresse subnet')
//param subnetPrefix string = '10.0.0.0/24'
param subnetPrefix string

@description('Nom du subnet')
param subnetName string = 'subnetlabel'


@description('Nom du network security group (NSG)')
param nsgName string = 'nsg${vnetName}'

@description('Adresse IP autorisée pour le SSH')
param sshAllowedIp string

var location = resourceGroup().location

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: [
      {
        name: 'Allow-SSH'
        properties: {
          priority: 1001
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourceAddressPrefix: sshAllowedIp
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '22'
        }
      }
      {
        name: 'Allow-HTTP'
        properties: {
          priority: 1002
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRanges: ['80', '443']
        }
      }
    ]
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [vnetAddressPrefix]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
          networkSecurityGroup: {
            id: nsg.id
          }
        }
      }
    ]
  }
}

output vnetId string = vnet.id
output subnetId string = vnet.properties.subnets[0].id
output nsgId string = nsg.id
output vnetName string = vnet.name
