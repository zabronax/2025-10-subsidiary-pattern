variable "desec_dns01_token" {
  description = <<EOT
INSECURE! The token for the deSEC DNS01 challenge. This is INSECURE, and only for a test server.
Access to this token (or similar DNS01 tokens) is potentially equivalent to full access to the domain/subdomain.
EOT
  type        = string
  sensitive   = true
}

module "compose-debian-cloud-init" {
  source                  = "./compose-debian-cloud-init"
  git_source              = "https://github.com/zabronax/2025-10-subsidiary-pattern.git"
  reconciliation_interval = "1min"
  branch                  = "main"
  manifest_path           = "test-infra/server/compose.yaml"
  desec_dns01_token       = var.desec_dns01_token
  floating_ipv4           = hcloud_floating_ip.primary_ipv4.ip_address
  floating_ipv6           = hcloud_floating_ip.primary_ipv6.ip_address
}

resource "hcloud_ssh_key" "ssh_key" {
  name       = "ssh_key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP5JL1ZtyUaBS7DsyFWdLzaalHDMA0ZExbDchJvOEjon"
}

locals {
  location = "hel1"
}

resource "hcloud_floating_ip" "primary_ipv4" {
  description   = "Primary IPv4 address"
  name          = "primary_ip"
  type          = "ipv4"
  home_location = local.location
}

resource "hcloud_floating_ip" "primary_ipv6" {
  description   = "Primary IPv6 address"
  name          = "primary_ipv6"
  type          = "ipv6"
  home_location = local.location
}

resource "hcloud_floating_ip_assignment" "primary_ipv4_assignment" {
  server_id      = hcloud_server.server.id
  floating_ip_id = hcloud_floating_ip.primary_ipv4.id
}

resource "hcloud_floating_ip_assignment" "primary_ipv6_assignment" {
  server_id      = hcloud_server.server.id
  floating_ip_id = hcloud_floating_ip.primary_ipv6.id
}

resource "hcloud_server" "server" {
  name        = "server"
  image       = "debian-12"
  server_type = "cx32"
  location    = local.location
  ssh_keys    = [hcloud_ssh_key.ssh_key.id]
  user_data   = module.compose-debian-cloud-init.cloud_init
}

output "server_addresses" {
  description = "The IPv4 and IPv6 addresses of the server"
  value = {
    ipv4 = hcloud_floating_ip.primary_ipv4.ip_address
    ipv6 = hcloud_floating_ip.primary_ipv6.ip_address
  }
}
