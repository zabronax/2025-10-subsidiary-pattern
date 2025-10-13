module "delegated_domain" {
  source             = "./modules/delegated-domain"
  cloudflare_zone_id = cloudflare_zone.apex.id

  ttl = local.ttl

  # Delegated domain configuration
  fqdn = "kodehode.${local.domain_name}"
  desec_name_servers = [
    "ns1.desec.io",
    "ns2.desec.org",
  ]

  dnssec_ds_records = [
    {
      key_tag     = "32103"
      digest      = "C61C16FD5F457047BFA7CBF94BDB58D754FBA55C3DF9F516C79018E96C9EE1AF"
      algorithm   = 13
      digest_type = 2
    },
    {
      key_tag     = "32103"
      digest      = "C468693C14F304F988AE93335EC2131EEACB26D6AABA2091130B141E5819FB90BFC1337DD59124487C834815265598AE"
      algorithm   = 13
      digest_type = 4
    }
  ]
}
