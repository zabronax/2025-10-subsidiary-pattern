module "compose-debian-cloud-init" {
  source                  = "./compose-debian-cloud-init"
  git_source              = "https://github.com/zabronax/2025-10-subsidiary-pattern.git"
  reconciliation_interval = "1min"
  branch                  = "main"
  manifest_path           = "test-infra/server/compose.yaml"
}

resource "hcloud_ssh_key" "ssh_key" {
  name       = "ssh_key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP5JL1ZtyUaBS7DsyFWdLzaalHDMA0ZExbDchJvOEjon"
}

resource "hcloud_floating_ip" "primary_ip" {
  name      = "primary_ip"
  type      = "ipv4"
  server_id = hcloud_server.server.id
}

resource "hcloud_server" "server" {
  name        = "server"
  image       = "debian-12"
  server_type = "cx32"
  location    = "hel1"
  ssh_keys    = [hcloud_ssh_key.ssh_key.id]
  user_data   = module.compose-debian-cloud-init.cloud_init
}

output "server_ip" {
  value = hcloud_server.server.ipv4_address
}
