locals {
  larsgunnar_server_ip = "46.62.222.201"
}

resource "cloudflare_dns_record" "www" {
  zone_id = cloudflare_zone.apex.id
  name    = "www"
  content = local.larsgunnar_server_ip
  type    = "A"
  ttl     = local.ttl
  proxied = false
}

resource "cloudflare_dns_record" "a_record" {
  zone_id = cloudflare_zone.apex.id
  name    = "@"
  type    = "A"
  content = local.larsgunnar_server_ip
  ttl     = local.ttl
  proxied = false
}
