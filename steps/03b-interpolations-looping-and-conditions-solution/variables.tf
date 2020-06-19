variable "gcp_project" {
  type        = string
  description = "GCP project used to deploy resources"
}

variable "bucket_name" {
  type        = string
  description = "Name of the GCS bucket"
}

variable "files" {
  type        = map(string)
  description = "Map of files to create where key is filename and value is content"

  default = {
    "config-pp"   = "env = pp"
    "config-prod" = "env = prod"
    "config-dev"  = "env = dev"
  }
}

