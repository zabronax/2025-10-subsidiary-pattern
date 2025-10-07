variable "git_source" {
  description = "The source URL for the git repository"
  type        = string
}

variable "reconciliation_interval" {
  description = "The interval for the reconciliation script"
  type        = string
}

variable "branch" {
  description = "The branch for the git repository"
  type        = string
}

variable "manifest_path" {
  description = "The path to the manifest file"
  type        = string
}

locals {
  reconciliation_interval = var.reconciliation_interval
  git_source              = var.git_source
  branch                  = var.branch
  manifest_path           = var.manifest_path

  reconciliation_script = templatefile("${path.module}/reconciliation-script.sh", {
    git_remote   = local.git_source
    branch       = local.branch
    compose_path = local.manifest_path
  })

  cloud_init = templatefile("${path.module}/cloud-init.yaml", {
    boot_delay               = "2min"
    reconciliation_intervall = local.reconciliation_interval
    # Mind the indentation here, as we are stiching this together manually (and hacky)
    indented_reconciliation_script = indent(6, local.reconciliation_script)
  })
}

output "cloud_init" {
  description = "Cloud-init configuration for the server"
  value       = local.cloud_init
}
