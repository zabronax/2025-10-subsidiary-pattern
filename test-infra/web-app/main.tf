terraform {
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "3.17.0"
    }
  }

  # This is Hetzner's Ceph Object Storage
  backend "s3" {
    bucket = "zabronax-state"
    key    = "test-infra/web-app/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

variable "vercel_token" {
  description = "The Vercel API token"
  type        = string
  sensitive   = true
}

provider "vercel" {
  api_token = var.vercel_token
}

# Variables
locals {
  parent_domain = "larsgunnar.no"
  subdomain     = "app"
  fqdn          = "${local.subdomain}.${local.parent_domain}"
}

# Project Configuration
resource "vercel_project" "web_app" {
  name = "test-web-app"

  root_directory = "test-infra/web-app"
  framework      = "nextjs"
  node_version   = "22.x"

  install_command = "pnpm install"
  build_command   = "pnpm build"

  git_repository = {
    type              = "github"
    repo              = "zabronax/2025-10-subsidiary-pattern"
    production_branch = "main"
  }
}

# Domain Configuration
resource "vercel_project_domain" "web_app_domain" {
  project_id = vercel_project.web_app.id
  domain     = local.fqdn
}

# TODO! Remove this once the domain delegation is propagated
# data "vercel_domain_config" "web_app_domain" {
#   project_id_or_name = vercel_project.web_app.id
#   domain             = local.fqdn
# }

output "web_app_recommended_cname" {
  description = "The recommended CNAME for the web app. Needs to be added to the parent's DNS record"
  value = {
    record_type = "cname"
    subdomain   = local.subdomain
    value       = "cname.vercel-dns.com" # TODO! Remove this once the domain delegation is propagated
    # value       = data.vercel_domain_config.web_app_domain.recommended_cname
  }
}
