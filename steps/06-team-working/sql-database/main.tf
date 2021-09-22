resource "random_password" "password" {
  // Create a new password with special chars and 16 characters
  length  = 16
  special = true
}

resource "google_sql_database_instance" "master" {
  // Create a new sql database with variables.tf content

  // We allow internet access only for lab purpose
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
  // Create the database user
}

resource "google_secret_manager_secret" "example" {
  // Create a secret in secret manager
}

resource "google_secret_manager_secret_version" "example" {
  // Put the password in a new version in the secret created above
}
