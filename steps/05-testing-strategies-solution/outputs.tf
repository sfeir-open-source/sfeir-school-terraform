output "project_id" {
  value = var.project_id
}

output "zone_name" {
  value = google_dns_managed_zone.private-zone.name
}

