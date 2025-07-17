@description('Recupere la region du ressource groupe')
param location string = resourceGroup().location

@description('Sequence unique du deploiement')
param sequence string = uniqueString(resourceGroup().id)

@description('Cle public de la vm source du deploiement')
param sshPublicKey string

@description('Defaut userlogin de la vm destination')
param adminUsername string = 'azureuser'

@description('IP public de la vm source du deploiement')
param allowedSshIp string // à adapter selon ton IP publique

@description('Préfixe par defaut d’adresse du VNet')
param vnetAddressPrefix string

@description('Préfixe par default plage addresse subnet')
param subnetPrefix string

module network './modules/network/network.bicep' = {
  name: 'network'
  params: {
    sshAllowedIp: allowedSshIp
    vnetName:'vNet-${sequence}'
    vnetAddressPrefix: vnetAddressPrefix
    subnetPrefix:subnetPrefix
  }
}

module publicIp './modules/network/publicIp.bicep' = {
  name: 'publicIp'
  params: {
    publicIpName: 'vmIP-${sequence}'
    dnsLabel: 'vmdns${sequence}'
  }
}

module nic './modules/nic/nic.bicep' = {
  name: 'nic'
  params: {
    nicName: 'nic-${sequence}'
    subnetId: network.outputs.subnetId
    nsgId: network.outputs.nsgId
    publicIpId: publicIp.outputs.publicIpId
  }
}

module vm './modules/compute/vm.bicep' = {
  name: 'vm'
  params: {
    vmName: 'host${sequence}'
    adminUsername: adminUsername
    sshPublicKey: sshPublicKey
    nicId: nic.outputs.nicId
  }
}

output vmPublicFqdn string = publicIp.outputs.publicFqdn
output vmNetName string = nic.outputs.nicName
