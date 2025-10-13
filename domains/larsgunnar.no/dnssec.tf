#########################################################
# Cloudflare DNS – DNSSEC configuration
#
# Enables DNSSEC signing for the apex domain (larsgunnar.no).
# DNSSEC adds cryptographic validation to all DNS responses,
# protecting clients from forged or tampered records (e.g. cache poisoning).
#
# Cloudflare automatically handles key generation, rotation,
# and RRSIG signing for all records under this zone.
#
# IMPORTANT:
#  - The parent zone (domain registrar) must publish a DS record
#    that links to Cloudflare’s signing key. Without it, DNSSEC
#    will remain in "pending" state and offer no protection.
#  - Once the DS record is added, Cloudflare will detect it and
#    automatically transition to "active" status.
#
# Note: DNSSEC cannot be fully automated via IaC because
# registrar integration is a manual (out-of-band) process.
#########################################################

# --- DNSSEC (Domain Name System Security Extensions) ---
# Activates DNSSEC signing for the apex zone and all subdomains
# that are not fully delegated elsewhere.
# 
# Cloudflare manages the DNSSEC keys internally. The `status`
# field is ignored to prevent perpetual drift during the
# asynchronous activation process.
#
# When creating a new zone or rotating keys, remember to update
# the DS record at your domain registrar using the values
# provided in the `dnssec_ds_record` output.
resource "cloudflare_zone_dnssec" "apex_dnssec" {
  zone_id = cloudflare_zone.apex.id
  status  = "active"

  lifecycle {
    # Cloudflare reports "pending" until the registrar publishes the DS record.
    # We ignore status changes to avoid infinite plan/apply loops.
    ignore_changes = [status]
  }
}

# --- Output: DNSSEC Delegation Signer (DS) Record ---------------
# Provides the DS record parameters required by the domain registrar
# to complete the DNSSEC chain of trust.
#
# The registrar must publish these values at the parent zone level.
# After propagation, Cloudflare will automatically mark DNSSEC as active.
#
# Example DS record fields:
#   Key Tag:     <key_tag>
#   Algorithm:   <algorithm>
#   Digest Type: <digest_type>
#   Digest:      <digest>
output "dnssec_ds_record" {
  description = <<EOT
Delegation Signer (DS) record to configure at your domain registrar.

Go to your registrar's DNSSEC section and add this record exactly as shown.
After propagation, Cloudflare will detect the DS record and mark DNSSEC as "active".

Note:
If this domain is ever re-created in Cloudflare, new DS values will be generated
and must be re-applied at the registrar.
EOT

  value = {
    algorithm   = cloudflare_zone_dnssec.apex_dnssec.algorithm
    digest      = cloudflare_zone_dnssec.apex_dnssec.digest
    digest_type = cloudflare_zone_dnssec.apex_dnssec.digest_type
    key_tag     = cloudflare_zone_dnssec.apex_dnssec.key_tag
  }
}
