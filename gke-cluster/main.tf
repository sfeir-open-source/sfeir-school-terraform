resource "google_project_service" "container" {
  project            = var.gcp_project
  service            = "container.googleapis.com"
  disable_on_destroy = false
}

resource "google_container_cluster" "primary" {
  // Create a GKE cluster using variables.tf values
  depends_on = ["google_project_service.container"]
}
