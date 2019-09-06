variable "username" {
  description = "Username to store on the secret"
}

variable "secret_path" {
  description = "The path in vault to store the secret"
}

resource "random_password" "password" {
  length  = 16
  special = true
}

resource "vault_generic_secret" "example" {
  path = var.secret_path

  data_json = <<EOT
{
  "user":     "${var.username}",
  "password": "${random_password.password.result}"
}
EOT
}
