variables {
  prefix = "sfeir"
  name = "test"
}

run "valid_string_concat" {
  command = plan

  assert {
    condition     = google_storage_bucket.bucket.name == "${var.prefix}-${var.name}"
    error_message = "GCS bucket name did not match expected"
  }
}


run "invalid_prefix_with_number" {
  command = plan
  variables {
    prefix = "sfeir42"
    name = "test"
  }
  expect_failures = [
    var.prefix,
  ]
}

run "invalid_prefix_too_short" {
  command = plan
  variables {
    prefix = "xx"
    name = "test"
  }
  expect_failures = [
    var.prefix,
  ]
}



run "invalid_prefix_too_long" {
  command = plan
  variables {
    prefix = "toolongforaprefix"
    name = "test"
  }
  expect_failures = [
    var.prefix,
  ]
}


run "invalid_name_with_numbers" {
  command = plan
  variables {
    prefix = "sfeir"
    name = "test42"
  }
  expect_failures = [
    var.name
  ]
}
