resource "google_compute_firewall" "dns-ingress" {
  project       = var.gcp_project
  name          = "allow-dns"
  network       = "default"
  description   = "Allow Ingress DNS from all networks"
  target_tags   = ["dns-server"]
  source_ranges = ["0.0.0.0/0"]

  dynamic "allow" {
    for_each = var.allowed_config

    content {
      ports    = allow.value.ports
      protocol = allow.value.protocol
    }
  }
}
