targetScope = 'subscription'
param location string = deployment().location
param suffix string = utcNow('ssfff')
param objectId string

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'purviewlab${suffix}-rg'
  location: location
}

module resources 'resources.bicep' = {
  name: 'resourcesDeploy'
  params: {
    location: location
    suffix: suffix
    objectId: objectId
  }
  scope: resourceGroup(rg.name)
}
