resource "google_project_service" "dns" {
  project            = var.gcp_project
  service            = "dns.googleapis.com"
  disable_on_destroy = "false"
}

resource "google_dns_managed_zone" "private-zone" {
  project    = var.gcp_project
  depends_on = [google_project_service.dns]
}

