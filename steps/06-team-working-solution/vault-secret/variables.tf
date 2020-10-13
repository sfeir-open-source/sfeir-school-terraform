variable "username" {
  description = "Username to store on the secret"
  default     = "user"
}

variable "secret_path" {
  description = "The path in vault to store the secret"
  default     = "secret/demo-secret-tf"
}
