terraform {
  required_version = ">= 0.12.0"
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

## Since 0.12
resource "google_storage_bucket_object" "files_for_each" {
  for_each = var.files
  name     = format("%s-for_each", lower(each.key))
  content  = each.value
  bucket   = google_storage_bucket.store.name
}

