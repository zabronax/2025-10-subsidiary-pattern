resource "github_repository_collaborator" "github_repository_collaborator" {
  repository = github_repository.github_repository.name
  username   = "bj-kodehode"
  permission = "pull"
}
