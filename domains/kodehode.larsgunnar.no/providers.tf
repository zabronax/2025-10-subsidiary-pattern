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

variable "desec_token" {
  description = "The API token for the deSEC DNS provider"
  type        = string
  sensitive   = true
}

provider "desec" {
  api_token = var.desec_token
}

output "desec_name_server" {
  description = "The name server for the deSEC DNS provider"
  value = [
    "ns1.desec.io",
    "ns2.desec.org",
  ]
}
