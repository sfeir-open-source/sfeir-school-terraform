terraform {
  required_version = ">= 0.12.0"
}

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

resource "google_storage_bucket" "store" {
  name     = var.bucket_name
  project  = var.gcp_project
  location = "EU"
}

## Before 0.12
resource "google_storage_bucket_object" "files_count" {
  count   = length(keys(var.files))
  name    = format("%s-count", lower(element(keys(var.files), count.index)))
  content = var.files[element(keys(var.files), count.index)]
  bucket  = google_storage_bucket.store.name
}


output "foo_count_res" {
  value = google_storage_bucket_object.files_count.*
}

## Since 0.12
resource "google_storage_bucket_object" "files_for_each" {
  for_each = var.files
  name     = format("%s-for_each", lower(each.key))
  content  = each.value
  bucket   = google_storage_bucket.store.name
}

output "foo_for_each_res" {
  value = google_storage_bucket_object.files_for_each.*
}

