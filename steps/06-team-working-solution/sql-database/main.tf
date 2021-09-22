resource "random_password" "password" {
  length  = 22
  special = true
}

resource "google_sql_database_instance" "master" {
  name    = var.instance_name
  project = var.gcp_project
  region  = var.region

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "internet"
        value = "0.0.0.0/0"
      }
    }
  }
}

resource "google_sql_user" "users" {
  name     = var.username
  project  = var.gcp_project
  instance = google_sql_database_instance.master.name
  password = random_password.password.result
}

resource "google_secret_manager_secret" "example" {
  project   = var.gcp_project
  secret_id = "demo-user"
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
