# Test functional (mode apply) sans credentials, via provider mocké
# Requiert Terraform >= 1.7 pour mock_provider.
#
# Le mock_provider simule le comportement du provider Google : aucune
# ressource n'est vraiment créée dans GCP, mais Terraform exécute quand
# même le cycle plan + apply complet et les assertions s'appliquent sur
# l'état final "simulé". Ideal en CI sans credentials.

mock_provider "google" {
  mock_resource "google_storage_bucket" {
    defaults = {
      self_link = "https://www.googleapis.com/storage/v1/b/mocked"
      url       = "gs://mocked-bucket"
    }
  }
}

run "apply_creates_bucket_with_expected_name" {
  command = apply

  variables {
    prefix = "sfeir"
    name   = "mocked"
  }

  assert {
    condition     = google_storage_bucket.bucket.name == "sfeir-mocked"
    error_message = "Le nom du bucket simulé ne correspond pas à la concaténation prefix-name"
  }

  assert {
    condition     = output.name == "sfeir-mocked"
    error_message = "L'output 'name' ne reflète pas le nom attendu"
  }
}
