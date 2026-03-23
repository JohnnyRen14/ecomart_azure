# EcoMart Azure Hybrid Cloud Prototype

**Prepared by:** Lee Ren Yee  
**Company:** NovaTech Solutions Ltd.  
**Client:** EcoMart  
**Module:** Cloud Infrastructure & Enterprise Services (INFO08018)  

---

## Overview

This repository contains the Infrastructure as Code (IaC) for the EcoMart Azure Hybrid Cloud prototype deployment. The infrastructure is deployed automatically to Microsoft Azure using GitHub Actions whenever code is pushed to the main branch.

---

## Architecture

The prototype demonstrates the following layers of EcoMart's proposed cloud architecture:

- **Virtual Network** — with Public and Private subnets (10.0.0.0/16)
- **Storage Account** — RA-GRS redundancy for product assets and backups
- **Resource Tagging** — mandatory tags enforced on all resources

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

**Resources deployed:**
- Resource Group: `rg-ecomart-prototype`
- Storage Account (Standard RA-GRS, Hot tier)
- Virtual Network with Public and Private subnets

---

## Cost Optimisation

All resources are tagged with mandatory labels for cost visibility:

| Tag | Value |
|---|---|
| Environment | prototype |
| CostCentre | IT-CLOUD |
| Project | ecomart-migration |
| Owner | lrenyee@novatech.com |

---

## Module

ATU — Cloud Infrastructure & Enterprise Services (INFO08018)  
