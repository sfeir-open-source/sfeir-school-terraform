resource "google_compute_firewall" "dns-ingress" {
  // Create a firewall rule with multiple protocol ports using new dynamic block loop
  description = "Allow Ingress DNS from all networks"
  target_tags = ["dns-server"]
}
