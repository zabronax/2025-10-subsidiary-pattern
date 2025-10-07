resource "github_repository" "github_repository" {
  name = "2025-10-subsidiary-pattern"
  description = "Example repository for the subsidiary pattern"
  visibility = "public"
}

output "github_repository_url" {
  description = "The URL of the GitHub repository"
  value = github_repository.github_repository.http_clone_url
  sensitive = false
}
