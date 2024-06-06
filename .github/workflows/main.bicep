
param location string = resourceGroup().location
param vmName string
param adminUsername string
param adminPassword string
 
resource vm 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }

    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'

      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }

    networkProfile: {
      networkInterfaces: [
        {
          id: '/subscriptions/612e9c82-8b7c-4474-b25f-ae40674ee67d/resourceGroups/rg1/providers/Microsoft.Network/networkInterfaces/BHvm'
        }
      ]
    }
  }
}
