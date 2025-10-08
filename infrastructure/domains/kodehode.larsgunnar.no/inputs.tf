variable "cloudflare_account_id" {
  description = "Cloudflare account ID for the account hosting the larsgunnar.no domain"
  type        = string
  sensitive   = true # Uncertain if this is sensitive, but it's a variable so we'll keep it that way
}
