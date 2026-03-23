// EcoMart Azure Prototype —  Cloud Infrastructure & Enterprise Services (INFO08018)
// NovaTech Solutions Ltd.

@description('Location for all resources')
param location string = 'northeurope'

@description('Environment tag')
param environment string = 'prototype'

// ── Storage Account ──────────────────────────────────────────
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'stecomart${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: 'Standard_RAGRS'
  }
  kind: 'StorageV2'
  tags: {
    Environment: environment
    CostCentre: 'IT-CLOUD'
    Project: 'ecomart-migration'
    Owner: 'lrenyee@novatech.com'
  }
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
  }
}

// ── Virtual Network ───────────────────────────────────────────
resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: 'vnet-ecomart-prototype'
  location: location
  tags: {
    Environment: environment
    CostCentre: 'IT-CLOUD'
    Project: 'ecomart-migration'
    Owner: 'lrenyee@novatech.com'
  }
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: 'PublicSubnet'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
      {
        name: 'PrivateSubnet'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}

// ── Outputs ───────────────────────────────────────────────────
output storageAccountName string = storageAccount.name
output vnetName string = vnet.name
