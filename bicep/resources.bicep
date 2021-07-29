targetScope = 'resourceGroup'
param location string
param suffix string

// // Azure Purview Account
// resource pv 'Microsoft.Purview/accounts@2020-12-01-preview' = {
//   name: 'purviewlab${suffix}-pv'
//   location: location
//   sku: {
//     name: 'Standard'
//     capacity: 4
//   }
//   identity: {
//     type: 'SystemAssigned'
//   }
// }

// // Azure Storage Account
// resource adls 'Microsoft.Storage/storageAccounts@2021-04-01' = {
//   name: 'purviewlab${suffix}adls'
//   location: location
//   kind: 'StorageV2'
//   sku: {
//     name: 'Standard_LRS'
//   }
//   properties: {
//     isHnsEnabled: true
//   }
// }

// // Azure SQL Server
// resource sqlsvr 'Microsoft.Sql/servers@2021-02-01-preview' = {
//   name: 'purviewlab${suffix}-sqlsvr'
//   location: location
//   properties: {
//     administratorLogin: 'sqladmin'
//     administratorLoginPassword: 'sqlPassword!'
//   }
// }

// // Azure SQL Database
// resource sqldb 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
//   parent: sqlsvr
//   name: 'purviewlab${suffix}-sqldb'
//   location: location
//   sku: {
//     name: 'GP_S_Gen5'
//     tier: 'GeneralPurpose'
//     family: 'Gen5'
//     capacity: 1
//   }
//   properties: {
//     collation: 'SQL_Latin1_General_CP1_CI_AS'
//     catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
//     autoPauseDelay: 60
//     requestedBackupStorageRedundancy: 'Local'
//     sampleName: 'AdventureWorksLT'
//   }
// }

// // Azure Key Vault
// resource kv 'Microsoft.KeyVault/vaults@2021-04-01-preview' = {
//   name: 'purviewlab${suffix}-keyvault'
//   location: location
//   properties: {
//     sku: {
//       family: 'A'
//       name: 'standard'
//     }
//     tenantId: subscription().tenantId
//     accessPolicies: []
//   }
// }

// // Azure Data Factory
// resource adf 'Microsoft.DataFactory/factories@2018-06-01' = {
//   name: 'purviewlab${suffix}-adf'
//   location: location
//   properties: {
//     publicNetworkAccess: 'Enabled'
//   }
//   identity: {
//     type: 'SystemAssigned'
//   }
// }

// Default Data Lake Storage Account (Synapse Workspace)
resource swsadls 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'purviewlab${suffix}swsadls'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    isHnsEnabled: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
  }
  resource service 'blobServices' = {
    name: 'default'
    resource container 'containers' = {
      name: 'synapsefs${suffix}'
    }
  }
}

// Azure Synapse Workspace
resource sws 'Microsoft.Synapse/workspaces@2021-05-01' = {
  name: 'purviewlab${suffix}-synapse'
  location: location
  properties: {
    defaultDataLakeStorage: {
      accountUrl: reference(swsadls.name).primaryEndpoints.dfs
      filesystem: 'synapsefs${suffix}'
    }
  }
  identity: {
    type: 'SystemAssigned'
  }
  resource firewall 'firewallRules' = {
    name: 'allowAll'
    properties: {
      startIpAddress: '0.0.0.0'
      endIpAddress: '255.255.255.255'
    }
  }
}

// resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-08-01-preview' = {
//   name: guid(swsadls.id)
//   properties: {
//     principalId: reference(sws.name,sws.apiVersion,'full').identity.principalId
//     roleDefinitionId: 'ba92f5b4-2d11-453d-a403-e96b0029c9fe'
//     principalType: 'ServicePrincipal'
//   }
// }
