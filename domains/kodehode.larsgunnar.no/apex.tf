locals {
  parent_domain_name = "larsgunnar.no"
  domain_name        = "kodehode"
  fqdn               = "${local.domain_name}.${local.parent_domain_name}"
  ttl                = 3600 # 1 hour
}

resource "desec_domain" "kodehode" {
  name = local.fqdn
}

output "kodehode_dnssec" {
  description = "CDS and CDNSKEY records"
  value = {
    cds     = desec_domain.kodehode.keys[0].ds
    cdnskey = desec_domain.kodehode.keys[0].dnskey
  }
}

resource "desec_rrset" "kodehode_record_a" {
  domain = local.fqdn
  ttl    = local.ttl

  subname = "" # Apex domain
  type    = "A"
  records = [
    "37.27.246.167",
  ]

  depends_on = [desec_domain.kodehode]
}

resource "desec_rrset" "kodehode_record_a_wildcard" {
  domain = local.fqdn
  ttl    = local.ttl

  subname = "*" # Wildcard domain
  type    = "A"
  records = [
    "37.27.246.167",
  ]

  depends_on = [desec_domain.kodehode]
}

output "kodehode_record_a" {
  description = "The A record for the kodehode.larsgunnar.no domain"
  value       = desec_rrset.kodehode_record_a
  sensitive   = false
}

output "kodehode_record_a_wildcard" {
  description = "The A record for the kodehode.larsgunnar.no domain"
  value       = desec_rrset.kodehode_record_a_wildcard
  sensitive   = false
}
