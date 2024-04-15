terraform {
  backend "gcs" {
    // Update value with the gcs bucket used to save state files
    bucket = "<bucket_name>"
    prefix = "<your_name>"
  }
}
