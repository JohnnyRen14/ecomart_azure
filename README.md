# EcoMart Azure Hybrid Cloud Prototype

**Prepared by:** Lee Ren Yee  
**Company:** NovaTech Solutions Ltd.  
**Client:** EcoMart  
**Module:** Cloud Infrastructure & Enterprise Services (INFO08018)  

---

## Overview

This repository contains the Infrastructure as Code (IaC) for the EcoMart Azure Hybrid Cloud prototype deployment. The infrastructure is deployed automatically to Microsoft Azure using GitHub Actions whenever code is pushed to the main branch.

---

## Repository Structure
```
ecomart-azure-prototype/
├── .github/
│   └── workflows/
│       └── deploy.yml        # GitHub Actions deployment pipeline
├── main.bicep                # Azure Bicep infrastructure template
└── README.md                 # This file
```

---

## Deployment

This prototype is deployed automatically via GitHub Actions to Microsoft Azure (North Europe region) when changes are pushed to the `main` branch.

A simplified deployment of EcoMart's proposed cloud architecture as a proof of concept. 
The following resources are deployed:

- **Resource Group** — `rg-ecomart-prototype` with mandatory cost tags
- **Virtual Network** — with Public and Private subnets (10.0.0.0/16)
- **Storage Account** — RA-GRS redundancy representing the storage layer
- **Virtual Machine** — representing the compute layer (Backend VM)

> Note: The full production architecture will include additional layers such as Azure Firewall, Application Gateway, Redis Cache, SQL Database and Azure Monitor.

---

## Module

ATU — Cloud Infrastructure & Enterprise Services (INFO08018)  
