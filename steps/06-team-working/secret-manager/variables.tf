variable "gcp_project" {
  description = "The GCP project ID."
}

variable "username" {
  description = "Username to store on the secret"
  default     = "user"
}

variable "secret_id" {
  description = "The secret id in GCP secret manager."
  default     = "demo-secret-manager"
}
