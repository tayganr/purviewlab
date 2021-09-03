var location = resourceGroup().location
var randomString = substring(guid(resourceGroup().id),0,6)

// Azure built-in role definitions
var roleDefinitionprefix = '/subscriptions/${subscription().subscriptionId}/providers/Microsoft.Authorization/roleDefinitions'
var role = {
  Owner: '${roleDefinitionprefix}/8e3af657-a8ff-443c-a75c-2fe8c4bcb635'
  Contributor: '${roleDefinitionprefix}/b24988ac-6180-42a0-ab88-20f7382dd24c'
  Reader: '${roleDefinitionprefix}/acdd72a7-3385-48ef-bd42-f606fba81ae7'
  UserAccessAdministrator: '${roleDefinitionprefix}/18d7d88d-d35e-4fb5-a5c3-7773c20a72d9'
  StorageBlobDataOwner: '${roleDefinitionprefix}/b7e6dc6d-f1e8-4753-8033-0f276bb0955b'
  StorageBlobDataContributor: '${roleDefinitionprefix}/ba92f5b4-2d11-453d-a403-e96b0029c9fe'
  StorageBlobDataReader: '${roleDefinitionprefix}/2a2b9908-6ea1-4ae2-8e65-a410df84e7d1'
}

// Azure Storage Account
resource adls 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'pvlab${randomString}adls'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    isHnsEnabled: true
  }
}

// Azure SQL Server
resource sqlsvr 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: 'pvlab-${randomString}-sqlsvr'
  location: location
  properties: {
    administratorLogin: 'sqladmin'
    administratorLoginPassword: 'sqlPassword!'
  }
  resource firewall1 'firewallRules' = {
    name: 'allowAzure'
    properties: {
      startIpAddress: '0.0.0.0'
      endIpAddress: '0.0.0.0'
    }
  }
  resource firewall2 'firewallRules' = {
    name: 'allowAll'
    properties: {
      startIpAddress: '0.0.0.0'
      endIpAddress: '255.255.255.255'
    }
  }
}

// Azure SQL Database
resource sqldb 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  parent: sqlsvr
  name: 'pvlab-${randomString}-sqldb'
  location: location
  sku: {
    name: 'GP_S_Gen5'
    tier: 'GeneralPurpose'
    family: 'Gen5'
    capacity: 1
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    autoPauseDelay: 60
    requestedBackupStorageRedundancy: 'Local'
    sampleName: 'AdventureWorksLT'
  }
}

// Azure Key Vault
resource kv 'Microsoft.KeyVault/vaults@2021-04-01-preview' = {
  name: 'pvlab-${randomString}-keyvault'
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: []
  }
}

// Azure Data Factory
resource adf 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: 'pvlab-${randomString}-adf'
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
  }
  identity: {
    type: 'SystemAssigned'
  }
}

// Default Data Lake Storage Account (Synapse Workspace)
resource swsadls 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'pvlab${randomString}synapse'
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
      name: 'synapsefs${randomString}'
    }
  }
}

// Azure Synapse Workspace
resource sws 'Microsoft.Synapse/workspaces@2021-05-01' = {
  name: 'pvlab-${randomString}-synapse'
  location: location
  properties: {
    defaultDataLakeStorage: {
      accountUrl: reference(swsadls.name).primaryEndpoints.dfs
      filesystem: 'synapsefs${randomString}'
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

// Role Assignment (Synapse Workspace Managed Identity -> Storage Blob Data Contributor)
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-08-01-preview' = {
  name: guid(resourceGroup().id)
  scope: swsadls
  properties: {
    principalId: reference(sws.name, sws.apiVersion, 'full').identity.principalId
    roleDefinitionId: role['StorageBlobDataContributor']
    principalType: 'ServicePrincipal'
  }
}


// Azure SQL VM
module sqlVm './sql_vm.bicep' = {
  name: 'SQLVMDeployment'
  params: {
    location: location
    randomString: randomString
  }
}
