module "delegated_domain_cluster" {
  source = "./modules/delegated-domain"

  # Delegated subdomain
  fqdn = "cluster.${local.domain_name}"

  cloudflare_zone_id = cloudflare_zone.apex.id
  ttl                = local.ttl

  desec_name_servers = [
    "ns1.desec.io",
    "ns2.desec.org",
  ]

  dnssec_ds_records = [
    {
      key_tag     = "17352"
      digest      = "ff54ad74633e8db6e242da78356187efad40216504a9bbe660d3e8771984dad6"
      algorithm   = 13
      digest_type = 2
    },
    {
      key_tag     = "17352"
      digest      = "206844e73b5d715b5e12838e300ebf5465cf9e98bd83d6f0e965b22481c47a81c4ad5e63da7747bf9167725634f97843"
      algorithm   = 13
      digest_type = 4
    }
  ]
}
