terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.11.0"
    }
  }
}

variable "cloudflare_token" {
  description = "Cloudflare API token for the larsgunnar.no domain"
  type        = string
  sensitive   = true
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}
