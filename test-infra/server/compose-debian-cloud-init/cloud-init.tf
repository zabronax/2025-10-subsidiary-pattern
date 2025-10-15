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

variable "desec_dns01_token" {
  description = "INSECURE! The token for the deSEC DNS01 challenge. This is INSECURE, and only for a test server."
  type        = string
  sensitive   = true
}

variable "floating_ipv4" {
  description = "The IPv4 address for the floating IP"
  type        = string
  sensitive   = false
}

variable "floating_ipv6" {
  description = "The IPv6 address for the floating IP"
  type        = string
  sensitive   = false
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
    # TODO! Don't do this for production workloads
    # This is only for a test server
    desec_dns01_token = var.desec_dns01_token
    floating_ipv4     = var.floating_ipv4
    floating_ipv6     = var.floating_ipv6
  })
}

output "cloud_init" {
  description = "Cloud-init configuration for the server"
  value       = local.cloud_init
}
