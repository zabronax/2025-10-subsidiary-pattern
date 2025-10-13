terraform {
  required_providers {
    desec = {
      source  = "Valodim/desec"
      version = "0.6.1"
    }
  }

  # This is Hetzner's Ceph Object Storage
  backend "s3" {
    bucket = "zabronax-state"
    key    = "kodehode.larsgunnar.no/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

variable "desec_api_token" {
  description = "The API token for the deSEC DNS provider"
  type        = string
  sensitive   = true
}

provider "desec" {
  api_token = var.desec_api_token
}
