resource "cloudflare_dns_record" "app_cname" {
  zone_id = cloudflare_zone.apex.id
  name    = "app"
  type    = "CNAME"
  content = "cname.vercel-dns.com"
  ttl     = local.ttl
}
