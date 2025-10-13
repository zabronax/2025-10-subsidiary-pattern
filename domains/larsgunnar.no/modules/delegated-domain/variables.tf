variable "cloudflare_zone_id" {
  description = <<-EOT
  The ID of the Cloudflare zone. Can be found in the Cloudflare dashboard or through their CLI.
  Example:
  - 1234567890
  EOT
  type        = string
  sensitive   = true
  nullable    = false
}

variable "fqdn" {
  description = <<-EOT
  The Fully Qualified Domain Name for the delegated domain
  Example:
  - kodehode.larsgunnar.no
  EOT
  type        = string
  sensitive   = false
  nullable    = false

  validation {
    error_message = "The FQDN must have at least three parts"
    condition     = length(split(".", var.fqdn)) >= 3
  }
}

variable "ttl" {
  description = <<-EOT
  The TTL for the domain's records
  Example:
  - 120
  EOT
  type        = number
  sensitive   = false
  nullable    = false

  validation {
    error_message = "The TTL must be a positive integer"
    condition     = var.ttl > 0
  }
}

variable "desec_name_servers" {
  description = <<-EOT
  The name servers for the domain
  Example:
  - ns1.desec.io
  - ns2.desec.org
  EOT
  type        = list(string)
  sensitive   = false
  nullable    = false

  validation {
    error_message = "The name servers must be a list of at least one name server"
    condition     = length(var.desec_name_servers) > 0
  }
}

variable "dnssec_ds_records" {
  description = <<-EOT
  The DS records for the domain, provided by the name server of the registrar tracking the delegated domain.
  Can be extracted using "dig +short CDS <domain> <name_server>".

  Example command:
  - dig +short CDS kodehode.larsgunnar.no ns1.desec.io

  Fields
  - key_tag: The key tag for the DS record
  - digest: The digest for the DS record
  - algorithm: The algorithm for the DS record
  - digest_type: The digest type for the DS record
  EOT
  type = list(object({
    key_tag     = string
    digest      = string
    algorithm   = number
    digest_type = number
  }))
  sensitive = false
  nullable  = false

  validation {
    error_message = "The DS records must be a list of at least one DS record"
    condition     = length(var.dnssec_ds_records) > 0
  }
}
