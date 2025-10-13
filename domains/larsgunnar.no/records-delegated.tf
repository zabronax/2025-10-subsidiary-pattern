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
      key_tag     = "45456"
      digest      = "2a00d5055658378daa4547f977276b8b1336d08ac141703bf06c4ce4cd4d66db"
      algorithm   = 13
      digest_type = 2
    },
    {
      key_tag     = "45456"
      digest      = "25103b3c686dddddd7fc3bc1fe4698f5e3f76dfdf666be1f01b719e4c8e76746c11cf6d90336444c92fd051f6d97302d"
      algorithm   = 13
      digest_type = 4
    }
  ]
}
