variable "username" {
  description = "Username to store on the secret"
  default     = "demo-user"
}

variable "secret_path" {
  description = "The path in vault to store the secret (must start with 'secret/')"
}
