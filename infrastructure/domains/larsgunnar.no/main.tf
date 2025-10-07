locals {
  # The Apex Domain Name
  domain_name = "larsgunnar.no"
  # The TTL for the records (in seconds), lower this before making changes
  # 60 to 86400 (24 hours) is valid values.
  # Once stable, increase this to at least 3600 (1 hour)
  ttl = 120
}

resource "cloudflare_zone" "apex" {
  account = {
    id = var.cloudflare_account_id
  }
  name = local.domain_name
  type = "full"
}

# --- DNSSEC for apex zone --------------------------------
# Enables DNSSEC signing for larsgunnar.no.
# Cloudflare automatically manages keys and signatures.
# This protects the apex zone and all records under it
# (except fully delegated subdomains).
resource "cloudflare_zone_dnssec" "apex_dnssec" {
  zone_id = cloudflare_zone.apex.id
}
