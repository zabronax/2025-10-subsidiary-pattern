locals {
  domain_name = "kodehode.larsgunnar.no"
  ttl         = 3600 # 1 hour

  records = [
    {
      type = "A"
      records = [
        "37.27.246.167",
      ]
    }
  ]
}

resource "desec_domain" "kodehode_larsgunnar_no" {
  name = local.domain_name
}

resource "desec_rrset" "kodehode_larsgunnar_no_records" {
  for_each = { for record in local.records : record.type => record }

  # Static values
  domain  = local.domain_name
  subname = "" # Apex record
  ttl     = local.ttl

  # Dynamic values
  type    = each.key
  records = each.value.records
}

output "kodehode_larsgunnar_no_records" {
  description = "The records for the kodehode.larsgunnar.no domain"
  value       = desec_rrset.kodehode_larsgunnar_no_records
}
