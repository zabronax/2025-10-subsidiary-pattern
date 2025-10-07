terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "6.6.0"
    }
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
