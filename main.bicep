// EcoMart Azure Prototype —  Cloud Infrastructure & Enterprise Services (INFO08018)
// NovaTech Solutions Ltd.

@description('Location for all resources')
param location string = 'northeurope'

@description('Environment tag')
param environment string = 'prototype'

@description('Admin username for the VM')
param adminUsername string = 'ecomart-admin'

@description('Admin password for the VM')
@secure()
param adminPassword string

// ── Tags ─────────────────────────────────────────────────────
var tags = {
  Environment: environment
  CostCentre: 'IT-CLOUD'
  Project: 'ecomart-migration'
  Owner: 'lrenyee@novatech.com'
}

// ── Virtual Network ───────────────────────────────────────────
resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: 'vnet-ecomart-prototype'
  location: location
  tags: tags
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

// ── Storage Account ───────────────────────────────────────────
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'stecomart${uniqueString(resourceGroup().id)}'
  location: location
  tags: tags
  sku: {
    name: 'Standard_RAGRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
  }
}

// ── Network Interface Card ────────────────────────────────────
resource nic 'Microsoft.Network/networkInterfaces@2023-05-01' = {
  name: 'nic-ecomart-vm'
  location: location
  tags: tags
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: vnet.properties.subnets[1].id
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

// ── Virtual Machine (Backend VM) ──────────────────────────────
resource vm 'Microsoft.Compute/virtualMachines@2023-07-01' = {
  name: 'vm-ecomart-backend'
  location: location
  tags: tags
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    osProfile: {
      computerName: 'ecomart-vm'
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
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

// ── Outputs ───────────────────────────────────────────────────
output storageAccountName string = storageAccount.name
output vnetName string = vnet.name
output vmName string = vm.name
