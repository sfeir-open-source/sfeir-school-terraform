# Sfeir Institute Terraform

## Module-5 : Testing strategies

### Using the Terraform Test Framework

You must have the version 1.6 at least since it's the first release to include the Terraform Test Framework

```
$ terraform version
```

### Create a simple terraform stack

Create a GCS (Google Cloud Storage) bucket with these constraints ([See help about variable validation](https://developer.hashicorp.com/terraform/language/values/variables#custom-validation-rules)):

- The name of the bucket will be composed of a prefix and a name like : <prefix>-<name>
- The `prefix` and `name` must contains only letter (no number/symbole)
- The `prefix` must be between 3 and 8 letters long.
- The `name` must be at least 3 letters long.

### Test your code

With the help of the [Terraform Test Framework documentation](https://developer.hashicorp.com/terraform/language/tests), write a Terraform test file to validate edge cases:

- `prefix="sfeir"` `name = "test"`, test should verify that the bucket name is set to `sfeir-test`
- `prefix="sfeir42"` `name = "test"` , test should fail
- `prefix="xx"` `name = "test"`, test should fail
- `prefix="toolongforaprefix"` `name = "test"`, test should fail
- `prefix="sfeir"` `name = "test42"`, test should fail

### Expected results :

```
$ terraform test
bucket.tftest.hcl... in progress
  run "valid_string_concat"... pass
  run "invalid_prefix_with_number"... pass
  run "invalid_prefix_too_short"... pass
  run "invalid_prefix_too_long"... pass
  run "invalid_name_with_numbers"... pass
bucket.tftest.hcl... tearing down
bucket.tftest.hcl... pass

Success! 5 passed, 0 failed.
```