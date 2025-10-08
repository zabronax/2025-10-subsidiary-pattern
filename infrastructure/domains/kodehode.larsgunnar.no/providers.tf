terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.11.0"
    }
  }

  # This is Hetzner's Ceph Object Storage
  backend "s3" {
    bucket = "zabronax-state"
    key    = "larsgunnar.no/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
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
