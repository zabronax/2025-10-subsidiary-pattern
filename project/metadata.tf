# GitHub Labels for automatic PR labeling
# These labels are used by the srvaroa/labler action to automatically categorize PRs

resource "github_issue_label" "automation" {
  repository  = github_repository.github_repository.name
  name        = "automation"
  color       = "0366d6"
  description = "Changes to CI/CD, workflows, and automation"
}

resource "github_issue_label" "documentation" {
  repository  = github_repository.github_repository.name
  name        = "documentation"
  color       = "0075ca"
  description = "Changes to documentation and README files"
}

resource "github_issue_label" "project" {
  repository  = github_repository.github_repository.name
  name        = "project"
  color       = "7057ff"
  description = "Changes to project configuration and infrastructure"
}

resource "github_issue_label" "domain" {
  repository  = github_repository.github_repository.name
  name        = "domain"
  color       = "0e8a16"
  description = "Changes to domain configuration and DNS"
}

resource "github_issue_label" "test" {
  repository  = github_repository.github_repository.name
  name        = "test"
  color       = "d73a4a"
  description = "Changes to test infrastructure and examples"
}
