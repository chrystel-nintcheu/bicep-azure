param location string = resourceGroup().location
param sshPublicKey string
param adminUsername string = 'azureuser'
param allowedSshIp string // à adapter selon ton IP publique

param sequence string = uniqueString(resourceGroup().id)

module network './modules/network/network.bicep' = {
  name: 'network-${sequence}'
  params: {
    sshAllowedIp: allowedSshIp
  }
}

module publicIp './modules/network/publicIp.bicep' = {
  name: 'publicIp-${sequence}'
  params: {
    publicIpName: 'vmPublicIP-${sequence}'
  }
}

module nic './modules/nic/nic.bicep' = {
  name: 'nic-${sequence}'
  params: {
    nicName: 'vmNic-${sequence}'
    subnetId: network.outputs.subnetId
    nsgId: network.outputs.nsgId
    publicIpId: publicIp.outputs.publicIpId
  }
}

module vm './modules/compute/vm.bicep' = {
  name: 'vm-${sequence}'
  params: {
    vmName: 'secureLnxVm-${sequence}'
    adminUsername: adminUsername
    sshPublicKey: sshPublicKey
    nicId: nic.outputs.nicId
  }
}
