locals {
  desec_name_servers = [
    "ns1.desec.io",
    "ns2.desec.org",
  ]
}

resource "cloudflare_dns_record" "kodehode_larsgunnar_no" {
  for_each = toset(local.desec_name_servers)

  zone_id = cloudflare_zone.apex.id
  name    = "kodehode"
  type    = "NS"
  content = each.value
  ttl     = local.ttl
}
