resource "github_repository" "github_repository" {
  name         = "2025-10-subsidiary-pattern"
  description  = "Example repository for the subsidiary pattern"
  visibility   = "public"
  homepage_url = "https://larsgunnar.no"

  topics = [
    "infrastructure-as-code",
    "opentofu",
    "terraform",
    "dns",
    "domain-delegation",
    "dnssec",
    "cloudflare",
    "desec",
    "subsidiary-pattern",
    "nix",
    "sops",
    "secrets-management",
    "iac",
    "devops",
    "gitops"
  ]
}

variable "github_action_identity" {
  description = "The identity for GitHub Actions"
  type        = string
  sensitive   = true
}

# GitHub Actions secret for SOPS decryption
resource "github_actions_secret" "sops_age_key" {
  repository      = github_repository.github_repository.name
  secret_name     = "SOPS_AGE_KEY"
  plaintext_value = var.github_action_identity
}

output "github_repository_url" {
  description = "The URL of the GitHub repository"
  value       = github_repository.github_repository.http_clone_url
  sensitive   = false
}
