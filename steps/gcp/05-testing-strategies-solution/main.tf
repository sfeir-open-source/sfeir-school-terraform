resource "google_storage_bucket" "bucket" {
  name     = format("%s-%s", var.prefix, var.name)
  location = "EU"
}
