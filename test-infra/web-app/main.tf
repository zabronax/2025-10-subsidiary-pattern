terraform {
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "3.17.0"
    }
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

resource "vercel_project" "web_app" {
  name      = "test-web-app"
  framework = "nextjs"
}

resource "vercel_project_domain" "web_app_domain" {
  project_id = vercel_project.web_app.id
  domain     = "app.larsgunnar.no"
}

data "vercel_domain_config" "web_app_domain" {
  project_id_or_name = vercel_project.web_app.id
  domain             = "app.larsgunnar.no"
}

output "web_app_recommended_cname" {
  description = "The recommended CNAME for the web app. Needs to be added to the parent's DNS record"
  value = {
    record_type = "cname"
    subdomain   = "app"
    value       = data.vercel_domain_config.web_app_domain.recommended_cname
  }
}
