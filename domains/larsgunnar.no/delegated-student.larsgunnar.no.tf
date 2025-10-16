module "delegated_domain_bj_student" {
  source = "./modules/delegated-domain"

  # Delegated subdomain
  fqdn = "bj.student.${local.domain_name}"

  cloudflare_zone_id = cloudflare_zone.apex.id
  ttl                = local.ttl

  desec_name_servers = [
    "ns1.desec.io",
    "ns2.desec.org",
  ]

  dnssec_ds_records = [
    {
      key_tag     = "13464"
      digest      = "1F8746B6439EA85A938310EED9BA8EF74DDC94484DDE3BE3B5DDB45A9B5AD07B"
      algorithm   = 13
      digest_type = 2
    },
    {
      key_tag     = "13464"
      digest      = "6FEEDEC85F2EC140471EFF81BC9D27FA933988B2F0A1FD1FAC1523E84D41A3B025398E272BA8A6904E864C71B882EDE4"
      algorithm   = 13
      digest_type = 4
    }
  ]
}

module "delegated_domain_jh_student" {
  source = "./modules/delegated-domain"

  # Delegated subdomain
  fqdn = "jh.student.${local.domain_name}"

  cloudflare_zone_id = cloudflare_zone.apex.id
  ttl                = local.ttl

  desec_name_servers = [
    "ns1.desec.io",
    "ns2.desec.org",
  ]

  dnssec_ds_records = [
    {
      key_tag     = "14810"
      digest      = "00649B27139669E51D3542DC0F75FFFDE3F911091E193817596B689CD18EE3DB"
      algorithm   = 13
      digest_type = 2
    },
    {
      key_tag     = "14810"
      digest      = "E2F2B7DF675615B9947BFD99A928B406AB5C14F8CEB2278BBF995473A8D130744211163FB81799415A248F3856EF2346"
      algorithm   = 13
      digest_type = 4
    }
  ]
}
