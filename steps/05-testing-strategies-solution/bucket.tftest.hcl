variables {
  bucket_prefix = "sfeir"
  bucket_name = "test"
}

run "valid_string_concat" {
  command = plan

  assert {
    condition     = google_storage_bucket.bucket.name == "${var.bucket_prefix}-${var.bucket_name}"
    error_message = "GCS bucket name did not match expected"
  }
}


run "invalid_prefix_with_number" {
  command = plan
  variables {
    bucket_prefix = "sfeir42"
    bucket_name = "test"
  } 
  expect_failures = [
    var.bucket_prefix,
  ]
}

run "invalid_prefix_too_short" {
  command = plan
  variables {
    bucket_prefix = "xx"
    bucket_name = "test"
  } 
  expect_failures = [
    var.bucket_prefix,
  ]
}



run "invalid_prefix_too_long" {
  command = plan
  variables {
    bucket_prefix = "toolongforaprefix"
    bucket_name = "test"
  } 
  expect_failures = [
    var.bucket_prefix,
  ]
}


run "invalid_name_with_numbers" {
  command = plan
  variables {
    bucket_prefix = "sfeir"
    bucket_name = "test42"
  } 
  expect_failures = [
    var.bucket_name
  ]
}