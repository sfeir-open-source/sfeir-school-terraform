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

