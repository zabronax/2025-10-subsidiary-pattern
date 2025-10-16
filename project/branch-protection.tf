resource "github_branch_protection" "main" {
  repository_id = github_repository.github_repository.node_id
  pattern       = "main"

  # Prevent direct pushes to main branch
  allows_force_pushes = false
  allows_deletions    = false

  # Require pull request reviews
  required_pull_request_reviews {
    required_approving_review_count = 0
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = false
  }

  # Require status checks to pass before merging
  required_status_checks {
    strict = true
    contexts = [
      "Continuous Integration"
    ]
  }

  # Enforce branch protection rules for administrators
  enforce_admins = true
}
