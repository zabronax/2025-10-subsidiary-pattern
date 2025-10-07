# --- CAA (restrict issuance for the apex only) ---
# Limits certificate issuance to Let's Encrypt.
# Does NOT affect delegated subdomains.
resource "cloudflare_dns_record" "caa_letsencrypt" {
  zone_id = cloudflare_zone.apex.id
  name    = local.domain_name
  type    = "CAA"
  data = {
    flags = "0"
    tag   = "issue"
    value = "letsencrypt.org"
  }
  ttl = local.ttl
}
