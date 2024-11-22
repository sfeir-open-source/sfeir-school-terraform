resource "random_password" "password" {
  length  = 16
  special = true
}

resource "google_sql_database_instance" "main" {
  name                = var.instance_name
  region              = var.region
  database_version    = var.database_version
  deletion_protection = false

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
  instance = google_sql_database_instance.main.name
  password = random_password.password.result
}

resource "vault_generic_secret" "example" {
  path = "secret/${var.instance_name}"

  data_json = jsonencode({
    user     = google_sql_user.users.name
    password = random_password.password.result
  })
}
