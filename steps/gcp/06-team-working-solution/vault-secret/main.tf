resource "random_password" "password" {
  length  = 16
  special = true
}

resource "vault_generic_secret" "example" {
  path = var.secret_path

  data_json = jsonencode({
    user     = var.username
    password = random_password.password.result
  })
}
