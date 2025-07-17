@description('Nom de l’IP publique')
param publicIpName string = 'publiciplabel'

@description('Préfixe DNS public (optionnel)')
param dnsLabel string = 'dnslabel'

resource publicIp 'Microsoft.Network/publicIPAddresses@2023-09-01' = {
  name: publicIpName
  location: resourceGroup().location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
     dnsSettings: {
      domainNameLabel: dnsLabel
    }
  }
}

output publicIpId string = publicIp.id
output publicIpName string = publicIp.name
output publicFqdn string = publicIp.properties.dnsSettings.fqdn
