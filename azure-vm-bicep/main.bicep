
@description('Nom de la VM')
param vmName string = 'secureLinuxVM'

@description('IP adresse de la session codespace en cours')
param codespacePublicIP string

@description('Nom d’utilisateur administrateur')
param adminUsername string

@description('Type d’authentification (clé SSH recommandée)')
@allowed([
  'sshPublicKey'
  'password'
])
param authenticationType string = 'sshPublicKey'

@description('Clé SSH publique ou mot de passe')
@secure()
param adminPasswordOrKey string

@description('Version Ubuntu')
@allowed([
  'Ubuntu-2004'
  'Ubuntu-2204'
])
param ubuntuOSVersion string = 'Ubuntu-2204'

@description('Type de sécurité de la VM')
@allowed([
  'Standard'
  'TrustedLaunch'
])
param securityType string = 'TrustedLaunch'

var imageReference = {
  'Ubuntu-2204': {
    publisher: 'Canonical'
    offer: '0001-com-ubuntu-server-jammy'
    sku: '22_04-lts-gen2'
    version: 'latest'
  }
}

var linuxConfiguration = {
  disablePasswordAuthentication: true
  ssh: {
    publicKeys: [
      {
        path: '/home/${adminUsername}/.ssh/authorized_keys'
        keyData: adminPasswordOrKey
      }
    ]
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
  name: '${vmName}-nsg'
  location: resourceGroup().location
  properties: {
    securityRules: [
      {
        name: 'Allow-SSH'
        properties: {
          priority: 1000
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '${codespacePublicIP}' // Remplacez par votre IP ou range sécurisé
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '22'
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: vmName
  location: resourceGroup().location
  properties: {
    hardwareProfile: { vmSize: 'Standard_D2s_v3' }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: { storageAccountType: 'Standard_LRS' }
      }
      imageReference: imageReference[ubuntuOSVersion]
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      linuxConfiguration: linuxConfiguration
    }
    securityProfile: (securityType == 'TrustedLaunch') ? {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: securityType
    } : null
    networkProfile: {
      networkInterfaces: [
        // Ajoutez ici la ressource d’interface réseau liée au NSG
      ]
    }
  }
}
