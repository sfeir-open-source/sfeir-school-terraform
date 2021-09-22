resource "random_password" "password" {
  // Create a random password
}

resource "google_secret_manager_secret" "example" {
  // Create a secret in secret manager
}

resource "google_secret_manager_secret_version" "example" {
  // Put the password in a new version in the secret created above
}
