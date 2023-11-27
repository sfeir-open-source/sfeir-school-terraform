resource "google_storage_bucket" "bucket" {
  name     = format("%s-%s", var.bucket_prefix, var.bucket_name)
  location = "EU"
}
