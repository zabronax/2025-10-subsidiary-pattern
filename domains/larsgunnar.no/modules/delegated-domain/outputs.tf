output "delegation_metadata" {
  value = {
    fqdn       = var.fqdn
    ns_records = [for r in cloudflare_dns_record.delegated_ns : r.content]
    ds_records = [for r in cloudflare_dns_record.delegated_ds : r.content]
    applied_at = timestamp()
  }
}
