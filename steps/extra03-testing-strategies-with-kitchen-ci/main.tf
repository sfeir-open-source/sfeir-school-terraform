resource "google_project_service" "dns" {
  service            = "dns.googleapis.com"
  disable_on_destroy = "false"
}

resource "google_dns_managed_zone" "private-zone" {
  depends_on = [google_project_service.dns]
}

