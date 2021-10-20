param location string
param randomString string 

var subnetName = 'pvlab-${randomString}-subnet'
var virtualNetworkName = 'pvlab-${randomString}-vnet'
var networkSecurityGroupName = 'pvlab-${randomString}-nsg'
var publicIpAddressName = 'pvlab-${randomString}-pub-ip'
var virtualMachineComputerName = 'pvlab${randomString}com'
var sqlVirtualMachineName = 'pvlab-${randomString}-sqlvm'

var adminUsername = 'sqladmin${randomString}'
var upperString = toUpper(randomString)
var adminPassword = '${randomString}!${upperString}@${randomString}'

resource networkInterface_resource 'Microsoft.Network/networkInterfaces@2018-10-01' = {
  name: 'pvlab-${randomString}-ni'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: subnetName
        properties: {
          subnet: {
            id: '${virtualNetwork_resource.id}/subnets/${subnetName}'
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIpAddress_resource.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroup_resource.id
    }
  }
  dependsOn: [
    networkSecurityGroup_resource
    virtualNetwork_resource
    publicIpAddress_resource
  ]
}

resource networkSecurityGroup_resource 'Microsoft.Network/networkSecurityGroups@2019-02-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: [
      {
      name: 'RDP'
      properties: {
        priority: 300
        protocol: 'Tcp'
        access: 'Allow'
        direction: 'Inbound'
        sourceAddressPrefix: '*'
        sourcePortRange: '*'
        destinationAddressPrefix: '*'
        destinationPortRange: '3389'
        }
      }
    ]
  }
}

resource virtualNetwork_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
      ]
    }
  }
  resource subnet_resource 'subnets' = {
    name: subnetName
    properties: {
      addressPrefix: '10.2.0.0/24'
    }
  }
}

resource publicIpAddress_resource 'Microsoft.Network/publicIpAddresses@2019-02-01' = {
  name: publicIpAddressName
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
  sku: {
    name: 'Basic'
  }
}

resource dataDiskResources_name 'Microsoft.Compute/disks@2020-12-01' = {
  name: 'pvlab-${randomString}_DataDisk'
  location: location
  sku: {
    name: 'Premium_LRS'
  }
  properties: {
    diskSizeGB: 8
    creationData: {
      createOption: 'Empty'
    }
  }
}

resource virtualMachineName_resource 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: sqlVirtualMachineName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2ms'
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
      imageReference: {
        publisher: 'microsoftsqlserver'
        offer: 'sql2019-ws2019'
        sku: 'sqldev'
        version: 'latest'
      }
      dataDisks: [
        {
        lun: 0
        createOption: 'Attach'
        caching: 'ReadOnly'
        diskSizeGB: 8
        managedDisk: {
          id: dataDiskResources_name.id
          storageAccountType: 'StandardSSD_LRS'
        }
        writeAcceleratorEnabled: false
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface_resource.id
        }
      ]
    }
    osProfile: {
      computerName: virtualMachineComputerName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        enableAutomaticUpdates: true
        provisionVMAgent: true
        patchSettings: {
          enableHotpatching: false
          patchMode: 'AutomaticByOS'
        }
      }
    }
  }
  dependsOn: [
    dataDiskResources_name
  ]
}

resource sqlVirtualMachineName_resource 'Microsoft.SqlVirtualMachine/SqlVirtualMachines@2017-03-01-preview' = {
  name: sqlVirtualMachineName
  location: location
  properties: {
    virtualMachineResourceId: resourceId('Microsoft.Compute/virtualMachines', sqlVirtualMachineName)
    sqlManagement: 'Full'
    sqlServerLicenseType: 'PAYG'
    autoPatchingSettings: {
      enable: true
      dayOfWeek: 'Sunday'
      maintenanceWindowStartingHour: 2
      maintenanceWindowDuration: 60
    }
    keyVaultCredentialSettings: {
      enable: false
      credentialName: ''
    }
    storageConfigurationSettings: {
      diskConfigurationType: 'NEW'
      storageWorkloadType: 'GENERAL'
      sqlDataSettings: {
        luns: [
          0
        ]
        defaultFilePath: 'F:\\data'
      }
      sqlLogSettings: {
         luns: [
          0
        ]
        defaultFilePath: 'F:\\log'
      }
      sqlTempDbSettings: {
        defaultFilePath: 'F:\\tempDb'
         luns: [
          0
        ]
      }
    }
    serverConfigurationsManagementSettings: {
      sqlConnectivityUpdateSettings: {
        connectivityType: 'PRIVATE'
        port: 1433
        sqlAuthUpdateUserName: ''
        sqlAuthUpdatePassword: ''
      }
      additionalFeaturesServerConfigurations: {
        isRServicesEnabled: false
      }
    }
  }
  dependsOn: [
    virtualMachineName_resource
  ]
}

output SQLVMadminUsername string = adminUsername
output SQLVMadminPassword string = adminPassword
