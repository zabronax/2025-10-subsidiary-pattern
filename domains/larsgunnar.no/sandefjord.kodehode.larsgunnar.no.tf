module "delegated_domain" {
  source = "./modules/delegated-domain"

  # Delegated subdomain
  fqdn = "sandefjord.kodehode.${local.domain_name}"

  cloudflare_zone_id = cloudflare_zone.apex.id
  ttl                = local.ttl

  desec_name_servers = [
    "ns1.desec.io",
    "ns2.desec.org",
  ]

  dnssec_ds_records = [
    {
      key_tag     = "26738"
      algorithm   = 13
      digest_type = 2
      digest      = upper("98df72f821b7086615bf894ae1aee9bec90ece242a35c9c9d4594b3938780713")
    },
    {
      key_tag     = "26738"
      algorithm   = 13
      digest_type = 4
      digest      = upper("fa42d2fb532d8fe5d1ed52c5d14356a2bb3c7995932ceb5c1c5a2369d3d37261134ec4866e2b6160753ab1cbf4f201b4")
    }
  ]
}
