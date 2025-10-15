terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.54.0"
    }
  }

  # This is Hetzner's Ceph Object Storage
  backend "s3" {
    bucket = "zabronax-state"
    key    = "test-infra/server/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

provider "hcloud" {
  token = var.hcloud_token
}
