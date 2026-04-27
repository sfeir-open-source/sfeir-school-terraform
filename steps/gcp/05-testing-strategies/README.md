# Sfeir Institute Terraform

## Module-5 : Testing strategies

### Using the Terraform Test Framework

You must have the version 1.6 at least since it's the first release to include the Terraform Test Framework

```
$ terraform version
```

### Create a simple terraform stack

Create a [GCS (Google Cloud Storage)](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) bucket with these constraints ([See help about variable validation](https://developer.hashicorp.com/terraform/language/values/variables#custom-validation-rules)):

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

### Bonus : test en mode `apply` avec `mock_provider` (Terraform 1.7+)

Le fichier `bucket_apply.tftest.hcl` propose un test **fonctionnel** (`command = apply`) qui utilise `mock_provider "google"` pour simuler la création du bucket sans avoir besoin de credentials GCP. Ce pattern est précieux en CI où l'on ne dispose pas toujours d'un compte de service GCP.

Complétez les `defaults` du `mock_resource` et les deux `assert` pour valider :

- `google_storage_bucket.bucket.name == "sfeir-mocked"`
- `output.name == "sfeir-mocked"`

Résultat attendu :

```
$ terraform test
...
bucket_apply.tftest.hcl... in progress
  run "apply_creates_bucket_with_expected_name"... pass
bucket_apply.tftest.hcl... tearing down
bucket_apply.tftest.hcl... pass

Success! 6 passed, 0 failed.
```

Référence : [Terraform Test — Mocking](https://developer.hashicorp.com/terraform/language/tests/mocking)
