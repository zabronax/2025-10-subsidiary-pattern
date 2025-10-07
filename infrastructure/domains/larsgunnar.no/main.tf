locals {
  # The Apex Domain Name
  domain_name = "larsgunnar.no"
  # The TTL for the records (in seconds), lower this before making changes
  ttl = 120
}

resource "cloudflare_zone" "apex" {
  account = {
    id = var.cloudflare_account_id
  }
  name = local.domain_name
  type = "full"
}
