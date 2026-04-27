variable "application_name" {
  type        = string
  description = "Application name"
}
variable "machine_type" {
  type        = string
  description = "GCE machine type"
  default     = "e2-micro"
}
