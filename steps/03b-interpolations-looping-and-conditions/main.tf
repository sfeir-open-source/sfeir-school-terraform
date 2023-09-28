terraform {
  required_version = ">= 0.12.0"
}


resource "google_storage_bucket" "store" {
  name     = var.bucket_name
  location = "EU"
}

## Since 0.12
resource "google_storage_bucket_object" "files_for_each" {
  // Put all files contained in var.files in cloud storage using for_each (add -for suffix in the file name)
  for_each = var.files
}

/*
*## Before 0.12
*resource "google_storage_bucket_object" "files_count" {
*  // Put all files contained in var.files in cloud storage using count (add -count suffix in the file name)
*  count   = length(keys(var.files))
*}
*/
