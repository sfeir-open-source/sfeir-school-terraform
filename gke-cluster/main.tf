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
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  depends_on = [google_project_service.container]
}

