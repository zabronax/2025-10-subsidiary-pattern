<div align="center">
  <a href="https://larsgunnar.no">
    <img alt="Logo" src="./docs/assets/logo.svg" height="128">
  </a>
  <h1>Subsidiary Pattern</h1>

  <div>
    <a href="https://larsgunnar.no"><img alt="Logo" src="https://img.shields.io/badge/MADE_BY_LG-441306?style=for-the-badge"></a>
    <a href="https://github.com/zabronax/2025-10-subsidiary-pattern/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/github/license/zabronax/2025-10-subsidiary-pattern?style=for-the-badge&labelColor=441306&color=441306"></a>
    <a href="https://opentofu.org/"><img alt="OpenTofu" src="https://img.shields.io/badge/OpenTofu-441306?style=for-the-badge&logo=opentofu"></a>
    <a href="https://nixos.org/"><img alt="Nix" src="https://img.shields.io/badge/Nix_Flake-441306?style=for-the-badge&logo=nixos"></a>
  </div>

  <div>
    <a href="https://github.com/zabronax/2025-10-subsidiary-pattern/actions/workflows/drift-detection.yaml"><img alt="Domain Governance" src="https://img.shields.io/github/actions/workflow/status/zabronax/2025-10-subsidiary-pattern/drift-detection.yaml?branch=main&style=for-the-badge&label=Domain%20Governance&labelColor=441306"></a>
    <a href="https://github.com/zabronax/2025-10-subsidiary-pattern/actions/workflows/continuous-deployment.yaml"><img alt="Continuous Deployment" src="https://img.shields.io/github/actions/workflow/status/zabronax/2025-10-subsidiary-pattern/continuous-deployment.yaml?branch=main&style=for-the-badge&label=Continuous%20Deployment&labelColor=441306"></a>
    <a href="https://github.com/zabronax/2025-10-subsidiary-pattern"><img alt="Repository Status" src="https://img.shields.io/github/last-commit/zabronax/2025-10-subsidiary-pattern?style=for-the-badge&label=Last%20Updated&labelColor=441306"></a>
  </div>
</div>

Example repository demonstrating the subsidiary pattern for Infrastructure as Code (IaC) organization and domain management.

## Overview

This repository demonstrates the subsidiary pattern for domain hierarchy management, where a parent organization delegates some subdomains to external providers while managing others directly. The implementation uses Infrastructure as Code (IaC) with GitOps workflows, ensuring version-controlled changes through Pull Requests.

Key governance features include centralized security policies (DNSSEC, email security), clear responsibility boundaries between parent and subsidiary domains, and support for both delegated and parent-managed subdomains.

For more complex setups, progressive delivery approaches may be worth considering. The next logical step would be implementing a cybernetic control solution using technologies like Talos with FluxCD, Prometheus, Flagger, and OPA for advanced deployment strategies, monitoring, and policy enforcement.

For detailed information about the subsidiary pattern, see the [documentation](./docs/subsidiary-pattern.md).

## Project Structure

### Domains
- **`domains/larsgunnar.no/`** - Primary domain infrastructure with static resources and delegated subdomains
- **`domains/kodehode.larsgunnar.no/`** - Dedicated domain configuration

### Project Management
- **`project/`** - GitHub repository and collaborator management

### Test Infrastructure
- **`test-infra/server/`** - Hetzner cloud server for verification
- **`test-infra/web-app/`** - Next.js application for verification

## Key Features

- **Domain Delegation**: Subdomain delegation with DNSSEC chain of trust
- **Multi-Provider DNS**: Cloudflare for static resources, deSEC for delegated domains
- **Subsidiary Pattern**: Hierarchical domain management with independent subdomain control
- **Security Policies**: Email security policies and certificate authority restrictions
- **Infrastructure as Code**: OpenTofu-based configuration management with secrets encryption
- **Continuous Workflows**: GitHub Actions for CI/CD and drift detection
- **Change Management**: Push-based deployment strategy with Pull Request reviews

## Technology Stack

### Infrastructure
- **OpenTofu** - Infrastructure provisioning
- **SOPS** - Secrets management
- **Nix** - Development environment
- **GitHub Actions** - CI/CD and automation

### DNS & Domains
- **Domeneshop** - Domain registrar
- **Cloudflare** - Primary DNS provider
- **deSEC** - Delegated domain DNS

### Verification
- **Hetzner Cloud** - Verifies A/AAAA records
- **Vercel** - Verifies CNAME with Vercel integration and Next.js deployment
- **Docker Compose** - Verifies Traefik subdomain handling and DNS01 challenges

## Development Environment

This project uses Nix for reproducible development environments:

```bash
nix develop
```

The development shell includes:
- OpenTofu for infrastructure management
- SOPS for secrets handling
- Age for encryption
- Just for task automation

## Task Management

This project uses [Just](https://github.com/casey/just) for task automation. Run `just` to see available tasks:

```bash
just --list
```

Key task categories:
- **IaC**: Infrastructure formatting, validation, and initialization
- **Secrets**: SOPS key management and rotation

## Important Notes

- **Secrets Management**: All sensitive data is encrypted using SOPS with Age keys
- **Domain Registration**: Primary domains are registered with Domeneshop
- **DNSSEC**: Requires manual DS record configuration at domain registrars

## External Links

### Core Tools
- [Nix](https://nixos.org/) - Package manager and development environment
- [OpenTofu](https://opentofu.org/) - Infrastructure as Code tool
- [SOPS](https://github.com/getsops/sops) - Secrets management
- [Age](https://age-encryption.org/) - Encryption tool for SOPS
- [Just](https://github.com/casey/just) - Task automation and project management
- [GitHub Actions](https://github.com/features/actions) - CI/CD and automation platform

### Documentation
- [Subsidiary Pattern Documentation](./docs/subsidiary-pattern.md) - Pattern explanation
- [Domain Infrastructure README](./domains/larsgunnar.no/README.md) - Domain-specific configuration details
