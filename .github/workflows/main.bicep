
// Define the Virtual Network
resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: BICEPvnet
  location: east-us
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: BICEPsubet
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
    ]
  }
}

// Define the Network Interface
resource nic 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: '${mbicep}-nic'
  location: east-us
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: vnet.properties.subnets[0].id
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

// Define the Virtual Machine
resource vm 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: mbicep
  location: east-us
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: mbicep
      adminUsername: madan
      adminPassword: madan12345678
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '18.04-LTS'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}

// Output the VM's ID
output vmId string = vm.id
    
