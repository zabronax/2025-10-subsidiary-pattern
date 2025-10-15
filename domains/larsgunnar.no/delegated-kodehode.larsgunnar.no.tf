module "delegated_domain" {
  source = "./modules/delegated-domain"

  # Delegated subdomain
  fqdn = "kodehode.${local.domain_name}"

  cloudflare_zone_id = cloudflare_zone.apex.id
  ttl                = local.ttl

  desec_name_servers = [
    "ns1.desec.io",
    "ns2.desec.org",
  ]

  dnssec_ds_records = [
    {
      key_tag     = "9903"
      digest      = "A36ABEEC05FD4A69EDBE94A0A0CCDF92B7CFF715A01A6976591A938E53796125"
      algorithm   = 13
      digest_type = 2
    },
    {
      key_tag     = "9903"
      digest      = "A21950C7B81D0A761B4CBBCC0190657A938D6F87916627455425CC1C5BBE3EC310A94AD729398A15B918A745553D8272"
      algorithm   = 13
      digest_type = 4
    }
  ]
}
