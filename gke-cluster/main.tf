variable "name" {
  description = "GKE cluster name"
}

variable "maschine_type" {
  description = "Default nodepool instance type"
  default     = "n1-standard-2"
}

variable "initial_node_count" {
  description = "Default nodepool instance count"
  default     = 1
}

variable "location" {
  description = "GKE cluster location"
  default     = "europe-west1-c"
}

variable "gcp_project" {
  description = "GKE cluster project"
}

resource "google_project_service" "container" {
  project            = var.gcp_project
  service            = "container.googleapis.com"
  disable_on_destroy = false
}

resource "google_container_cluster" "primary" {
  project            = var.gcp_project
  name               = var.name
  location           = var.location
  initial_node_count = var.initial_node_count

  node_config {
    machine_type = var.maschine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  depends_on = ["google_project_service.container"]
}

output "endpoint" {
  description = "GKE API endpoint"
  value       = google_container_cluster.primary.endpoint
}

output "gcp_project" {
  value = var.gcp_project
}
