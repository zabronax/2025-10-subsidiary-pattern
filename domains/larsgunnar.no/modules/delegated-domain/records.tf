resource "cloudflare_dns_record" "delegated_ns" {
  for_each = toset(var.desec_name_servers)

  zone_id = var.cloudflare_zone_id
  name    = var.fqdn
  type    = "NS"
  content = each.value
  ttl     = var.ttl
}

resource "cloudflare_dns_record" "delegated_ds" {
  for_each = { for ds in var.dnssec_ds_records : ds.digest => ds }

  zone_id = var.cloudflare_zone_id
  name    = var.fqdn
  type    = "DS"
  ttl     = var.ttl
  data = {
    key_tag     = each.value.key_tag
    digest      = upper(each.value.digest)
    algorithm   = each.value.algorithm
    digest_type = each.value.digest_type
  }
}
