# larsgunnar.no Domain Infrastructure

Infrastructure as Code (IaC) configuration for managing the `larsgunnar.no` domain and its subdomains.

## Static Resources

Direct DNS records managed by Cloudflare:
- **Apex domain**: `larsgunnar.no` with A/AAAA records pointing to a server
- **App subdomain**: `app.larsgunnar.no` pointing to Vercel
- **Security policies**: DNSSEC, SPF, DKIM, DMARC, and CAA records

## Delegated Domains

Subdomains delegated to external name servers:
- **kodehode.larsgunnar.no**: Delegated to deSEC name servers
- ***.student.larsgunnar.no**: Delegated to deSEC name servers (extensible for additional students)

## Key Features

- **DNSSEC**: Cryptographic validation for DNS responses
- **Email security**: Strict policies preventing unauthorized email sending
- **Certificate authority**: Restricted to Let's Encrypt only
- **Secure delegation**: DNSSEC chain of trust for delegated subdomains

## External Links

### Domain & DNS Providers
- [Domeneshop](https://domeneshop.no) - Domain registrar
- [Cloudflare](https://cloudflare.com) - DNS provider for static resources
- [deSEC](https://desec.io) - DNS provider for delegated domains

### IaC Documentation
- [Cloudflare Provider](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs) - Terraform Registry
- [deSEC API Documentation](https://desec.io/api/) - API reference for delegated domains

## Important Notes

- **Domain registration**: The `larsgunnar.no` domain is registered with Domeneshop
- DNSSEC requires manual DS record configuration at the domain registrar
- Email security policies are set to reject all mail (change if sending email)
- TTL is set to 120 seconds for testing; increase to 3600+ for production
