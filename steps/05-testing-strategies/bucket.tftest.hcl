variables {
  bucket_prefix = ...
  bucket_name = ...
}

run "valid_string_concat" {
  command = plan

  ...
}


run "invalid_prefix_with_number" {
  command = plan

  variables {
    bucket_prefix = "sfeir42"
    bucket_name = "test"
  } 

  ...
}

run "invalid_prefix_too_short" {
  command = plan

  variables {
    bucket_prefix = "xx"
    bucket_name = "test"
  } 

  ...
}



run "invalid_prefix_too_long" {
  command = plan

  variables {
    bucket_prefix = "toolongforaprefix"
    bucket_name = "test"
  } 

  ...
}


run "invalid_name_with_numbers" {
  command = plan

  variables {
    bucket_prefix = "sfeir"
    bucket_name = "test42"
  }

  ...
}