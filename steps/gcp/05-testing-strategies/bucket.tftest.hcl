variables {
  prefix = ...
  name = ...
}

run "valid_string_concat" {
  command = plan

  ...
}


run "invalid_prefix_with_number" {
  command = plan

  variables {
    prefix = "sfeir42"
    name = "test"
  }

  ...
}

run "invalid_prefix_too_short" {
  command = plan

  variables {
    prefix = "xx"
    name = "test"
  }

  ...
}



run "invalid_prefix_too_long" {
  command = plan

  variables {
    prefix = "toolongforaprefix"
    name = "test"
  }

  ...
}


run "invalid_name_with_numbers" {
  command = plan

  variables {
    prefix = "sfeir"
    name = "test42"
  }

  ...
}
