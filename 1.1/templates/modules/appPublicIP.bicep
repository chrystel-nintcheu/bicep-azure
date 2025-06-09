param location string
param customName string
param appServiceAppName string

resource publicIP 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: customName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    dnsSettings: {
      domainNameLabel: appServiceAppName
    }
  }
}

output ipAddress string = publicIP.properties.ipAddress
output fqdn string = publicIP.properties.dnsSettings.fqdn
