variable "gcp_project" {
  type        = string
  description = "GCP project use to deploy resources."
}

variable "allowed_config" {
  type = list
  default = [
    {
      ports    = ["53"]
      protocol = "TCP"
    },
    {
      ports    = ["53"]
      protocol = "UDP"
    }
  ]
}
resource "google_compute_firewall" "dns-ingress" {
  project     = var.gcp_project
  name        = "allow-dns"
  network     = "default"
  description = "Allow Ingress DNS from all networks"
  target_tags = ["dns-server"]


  dynamic "allow" {
    for_each = [for config in var.allowed_config : {
      ports    = config.ports
      protocol = config.protocol
    }]

    content {
      ports    = allow.value.ports
      protocol = allow.value.protocol
    }
  }
}
