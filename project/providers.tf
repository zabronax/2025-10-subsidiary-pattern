terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "6.6.0"
    }
  }

  # This is Hetzner's Ceph Object Storage
  backend "s3" {
    bucket = "zabronax-state"
    key    = "project/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

variable "gh_token" {
  description = "GitHub token for the project's repository"
  type = string
  sensitive = true
}

provider "github" {
  token = var.gh_token
}
