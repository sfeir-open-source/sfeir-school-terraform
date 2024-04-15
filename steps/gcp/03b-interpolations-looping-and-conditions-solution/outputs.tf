output "foo_count_res" {
  value     = google_storage_bucket_object.files_count.*
  sensitive = true
}

output "foo_for_each_res" {
  value     = google_storage_bucket_object.files_for_each.*
  sensitive = true
}
