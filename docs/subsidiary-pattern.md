# Subsidiary Pattern

An organizational domain‑splitting pattern implemented through Infrastructure as Code (IaC), enabling clear delegation and governance across domain hierarchies.

## Overview

The Subsidiary Pattern is a governance model for domain hierarchies where a parent organization:
- delegates some subdomains to external providers (delegated subdomains),
- manages other subdomains directly (parent‑managed subdomains), and
- enables fully independent subsidiaries that may live in separate repositories.

All changes follow a GitOps workflow: version-controlled, proposed via Pull Requests, reviewed, and automatically reconciled to the desired state. The parent enforces centralized policies (e.g., DNSSEC, email security) while subsidiaries retain clear responsibility boundaries.

## Core Concepts

### Domain Hierarchy
- **Parent Domain**: The root domain managed centrally
- **Delegated Subdomains**: Subdomains delegated to external providers
- **Managed Subdomains**: Subdomains managed directly by the parent organization
- **Independent Subsidiaries**: Completely independent domain management, potentially in separate repositories

## Pattern Structure

```
domains/
├── parent-domain.com/
│   ├── delegated-subdomain-1.tf
│   ├── delegated-subdomain-2.tf
│   ├── ...
│   ├── delegated-subdomain-N.tf
│   ├── managed-subdomain-1.tf
│   ├── managed-subdomain-2.tf
│   ├── ...
│   └── managed-subdomain-M.tf
├── sub1.parent-domain.com/
├── sub2.parent-domain.com/
├── ...
└── subK.parent-domain.com/
```

## Responsibility Separation

### Parent Domain Responsibilities
- Domain registration and renewal
- DNSSEC root key management
- Security policies (SPF, DKIM, DMARC)
- NS and DS record management for delegations
- Certificate authority restrictions

### Subsidiary Responsibilities
- Subdomain DNS management
- DNSSEC key generation and DS record provision
- Service-specific configurations
- Independent infrastructure management

## Motivation

- **Centralization**: Central IT maintains control over the parent domain and security policies
- **Delegation**: Teams and departments can independently manage their subdomain infrastructure
- **Management**: Parent organization can manage subsidiary subdomains when needed
- **Version Control**: GitOps approach with infrastructure as code as the single source of truth
- **Standardized Change Process**: Changes flow through Pull Requests with review
- **Automated Reconciliation**: Approved changes are applied automatically; drift is detected and corrected

## Security Considerations

- Maintain DNSSEC chain of trust across all delegations
- Implement proper DS record validation
- Use secure key management for DNSSEC keys
- Regular monitoring of delegation health
