targetScope = 'resourceGroup'
param location string = resourceGroup().location
// Add your resources here
targetScope = 'resourceGroup'
param location string = resourceGroup().location
param loadTestName string = 'loadtest-\${uniqueString(resourceGroup().id)}'

// Azure Load Testing Resource
resource loadTest 'Microsoft.LoadTestService/loadTests@2022-12-01' = {
  name: loadTestName
  location: location
  properties: {
    description: 'Load testing for moj-perf'
  }
}

// Storage Account for test data and results
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'stload\${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: false
  }
}

output loadTestId string = loadTest.id
output loadTestName string = loadTest.name
output storageAccountName string = storageAccount.name
