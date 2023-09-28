resource "random_password" "password" {
  // Create a new password with special chars and 16 characters
}

resource "google_sql_database_instance" "main" {
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

resource "vault_generic_secret" "example" {
  // Put the password in vault
  path = "secret/${var.instance_name}"
}

