#########################################################
# Cloudflare DNS – Baseline security and mail policy
#
# This file defines TXT records that explicitly state:
#  - The domain does NOT send mail (SPF)
#  - There are no DKIM signing keys (DKIM placeholder)
#  - All unauthenticated mail should be REJECTED (DMARC)
#
# These records harden the domain against spoofing and phishing.
# Do NOT modify these unless the domain begins sending mail.
#########################################################

# --- SPF (Sender Policy Framework) ---------------------
# Tells receiving mail servers which IPs are allowed to send mail.
# The "-all" directive means: “no one is authorized to send mail”.
# This prevents spammers from impersonating the domain in From: headers.
#
# Change this only if legitimate outbound email is configured,
# in which case authorized mail senders must be explicitly listed.
resource "cloudflare_dns_record" "spf" {
  zone_id = cloudflare_zone.apex.id
  name    = local.domain_name
  type    = "TXT"
  content = "v=spf1 -all"
  ttl     = local.ttl
}

# --- DKIM (DomainKeys Identified Mail) -----------------
# Provides cryptographic verification of email origin.
# Here we define a WILDCARD DKIM placeholder record to signal that
# no valid DKIM public keys exist for this domain.
#
# The empty `p=` value ensures that lookups for DKIM selectors
# return a valid TXT record (reducing false-positive errors)
# but provide no usable signing key.
#
# When enabling real outbound email, each mail provider (e.g., SES, Gmail)
# will supply its own selector record, typically:
#   selector1._domainkey.<domain>
resource "cloudflare_dns_record" "dkim_placeholder" {
  zone_id = cloudflare_zone.apex.id
  name    = "*._domainkey"
  type    = "TXT"
  content = "v=DKIM1; p="
  ttl     = local.ttl
}

# --- DMARC (Domain-based Message Authentication, Reporting & Conformance) ---
# Specifies what to do when SPF/DKIM validation fails for mail claiming
# to come from this domain.
#
#  p=reject   → reject messages failing authentication outright.
#  sp=reject  → apply same rule to all subdomains.
#  adkim=s    → strict DKIM alignment (From: must match signing domain exactly).
#  aspf=s     → strict SPF alignment (envelope domain must match From:).
#
# This is the recommended baseline for domains that send NO mail.
# For active mail domains, change `p=` to "quarantine" or "none" and
# configure rua/ruf tags for DMARC reporting.
resource "cloudflare_dns_record" "dmarc_reject" {
  zone_id = cloudflare_zone.apex.id
  name    = "_dmarc"
  type    = "TXT"
  content = "v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s;"
  ttl     = local.ttl
}
