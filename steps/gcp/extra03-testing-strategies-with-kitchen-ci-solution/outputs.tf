output "gcp_project" {
  value = var.gcp_project
}

output "zone_name" {
  value = google_dns_managed_zone.private-zone.name
}
