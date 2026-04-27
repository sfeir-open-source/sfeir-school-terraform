# Bonus : test fonctionnel en mode `apply` avec provider mocké
# Requiert Terraform >= 1.7
#
# Objectif : valider qu'un `terraform apply` produirait bien un bucket
# avec le nom attendu, SANS avoir besoin de credentials GCP (utile en CI).
#
# Piste : `mock_provider "google"` permet de simuler la création de
# ressources Google. On peut ensuite écrire un `run` avec `command = apply`
# et des assertions sur la ressource et sur l'output.

mock_provider "google" {
  mock_resource "google_storage_bucket" {
    defaults = {
      # Valeurs "computed" simulées par le mock
      # ...
    }
  }
}

run "apply_creates_bucket_with_expected_name" {
  command = apply

  variables {
    prefix = "sfeir"
    name   = "mocked"
  }

  # Assertion 1 : la ressource google_storage_bucket.bucket a le bon nom
  # ...

  # Assertion 2 : l'output "name" expose le bon nom
  # ...
}
