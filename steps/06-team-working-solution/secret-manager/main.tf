resource "random_password" "password" {
  length  = 16
  special = true
}

resource "google_secret_manager_secret" "example" {
  project   = var.gcp_project
  secret_id = var.secret_id
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "example" {
  secret      = google_secret_manager_secret.example.id
  secret_data = <<EOT
{
  "user":     "${var.username}",
  "password": "${random_password.password.result}"
}
EOT
}
