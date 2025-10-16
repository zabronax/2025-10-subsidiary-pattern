locals {
  larsgunnar_server_ipv4 = "65.109.240.156"
  larsgunnar_server_ipv6 = "2a01:4f9:c01f:49::"
  fobar                  = "fobar"
}

resource "cloudflare_dns_record" "www" {
  zone_id = cloudflare_zone.apex.id
  name    = "www"
  content = local.larsgunnar_server_ipv4
  type    = "A"
  ttl     = local.ttl
  proxied = false
}

resource "cloudflare_dns_record" "a_record" {
  zone_id = cloudflare_zone.apex.id
  name    = "@"
  type    = "A"
  content = local.larsgunnar_server_ipv4
  ttl     = local.ttl
  proxied = false
}

resource "cloudflare_dns_record" "aaaa_record" {
  zone_id = cloudflare_zone.apex.id
  name    = "@"
  type    = "AAAA"
  content = local.larsgunnar_server_ipv6
  ttl     = local.ttl
  proxied = false
}
