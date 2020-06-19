variable "gcp_project" {
  type        = string
  description = "The GCP project ID"
}

variable "initial_node_count" {
  type        = string
  description = "Number of GKE node to deploy"
  default     = "1"
}

variable "location" {
  type        = string
  description = "Location of the GKE cluster"
  default     = "europe-west1"
}

variable "machine_type" {
  type        = string
  description = "Size of GKE node"
  default     = "n1-standard-1"
}

variable "name" {
  type        = string
  description = "Name of the GKE cluster"
  default     = "demo-cluster"
}

