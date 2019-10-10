resource "google_project_service" "dns" {
  project            = "${var.gcp_project}"
  service            = "dns.googleapis.com"
  disable_on_destroy = "false"
}

resource "google_dns_managed_zone" "private-zone" {
  name    = "demo-local"
  project = "${var.gcp_project}"

  dns_name = "demo.local."

  visibility = "private"
  private_visibility_config {
    networks {
      network_url = "https://www.googleapis.com/compute/v1/projects/${var.gcp_project}/global/networks/default"
    }
  }

  depends_on = ["google_project_service.dns"]
}
