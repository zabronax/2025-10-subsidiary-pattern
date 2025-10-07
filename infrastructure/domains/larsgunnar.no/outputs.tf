output "domain_apex" {
  description = "Information about the apex domain"
  value = {
    domain_name = local.domain_name
  }
  sensitive = false
}
