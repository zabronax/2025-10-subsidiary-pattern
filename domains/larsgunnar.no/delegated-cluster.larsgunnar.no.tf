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
      key_tag     = "22897"
      digest      = "74EB0E251805E0D823557450252DE2EFE74F88E3AA8E163AE819D2CE14C855C9"
      algorithm   = 13
      digest_type = 2
    },
    {
      key_tag     = "22897"
      digest      = "BEDF264FEEAB348E8057185F7006FA02E9C99B3BD5C36BAC89FFFEE50EC3F1DF92E17E20B80FF29B4B66789AE4C52578"
      algorithm   = 13
      digest_type = 4
    }
  ]
}
