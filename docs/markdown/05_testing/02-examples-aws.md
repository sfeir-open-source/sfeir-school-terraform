<!-- .slide:-->

# L’exemple de Terratest

![h-650 float-left](./assets/images/terratest_sample.png)

![float-left](./assets/images/terratest_logo.png)

Notes:
Terratest teste l'infra déployée (boîte noire via les outputs), terraform test teste surtout le contrat du module.
Ce que Terratest permet en plus de terraform test :
- Exécuter du code arbitraire (Go) : SSH sur une VM, commande dans un conteneur, appel SDK cloud
- Logique procédurale : boucles, attente d'un état, scénarios en plusieurs étapes
- Tester autre chose que Terraform : Packer, Docker, Helm, Kubernetes

##==##

<!-- .slide: class="with-code-bg-dark"-->

# L’exemple du Terraform Testing Framework

Exemple de code Terraform (`main.tf`) :

```hcl-terraform
provider "aws" {
    region = "eu-central-1"
}

variable "bucket_prefix" {
  type = string
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_prefix}-bucket"
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}
```

Disponible depuis la v1.6.0 de Terraform. Provider mocking disponible depuis v1.7.

##==##

<!-- .slide: class="with-code-bg-dark"-->

# Terraform Testing Framework (`main.tftest.hcl`)

Test unitaire — `command = plan` :

```hcl-terraform
run "valid_string_concat" {
  command = plan
  assert {
    condition     = aws_s3_bucket.bucket.bucket == "test-bucket"
    error_message = "S3 bucket name did not match expected"
  }
}
```

Test fonctionnel — `command = apply` :

```hcl-terraform
run "validate_bucket_created" {
  command = apply
  assert {
    condition     = output.bucket_name == "test-bucket"
    error_message = "Le bucket créé n’a pas le nom attendu"
  }
}
```

Notes:
command = plan : validation sans déploiement (rapide, pas de credentials nécessaires avec mocking)
command = apply : déploiement réel puis assertions sur les ressources créées
Provider mocking (v1.7+) : tester sans credentials via mock_provider blocks
Voir : https://developer.hashicorp.com/terraform/language/tests

##==##

<!-- .slide: class="with-code-bg-dark"-->

# Terraform Testing Framework — `mock_provider` (v1.7+)

Tester un `apply` **sans credentials** grâce au provider mocké :

```hcl-terraform
mock_provider "aws" {
  mock_resource "aws_s3_bucket" {
    defaults = {
      arn = "arn:aws:s3:::mocked"
    }
  }
}

run "apply_creates_bucket" {
  command = apply

  variables {
    bucket_prefix = "test"
  }

  assert {
    condition     = aws_s3_bucket.bucket.bucket == "test-bucket"
    error_message = "Bucket name mismatch"
  }

  assert {
    condition     = output.bucket_name == "test-bucket"
    error_message = "Output mismatch"
  }
}
```

<span style="color:green">Idéal en CI : pas besoin d’AWS/GCP credentials, aucune ressource n’est réellement créée.</span>

Notes:
mock_provider simule la création : Terraform exécute le cycle complet plan + apply, mais aucune API cloud n'est appelée.
Les attributs computed (arn, id, ...) sont renseignés via `defaults` ou générés par Terraform (known after apply).
Parfait complément du mode `plan` avec `expect_failures` : on couvre unitaire + fonctionnel sans jamais toucher au cloud.

On peut également surcharger ponctuellement une ressource, une data source ou un module :
  override_resource {
    target = aws_s3_bucket.bucket
    values = { arn = "arn:aws:s3:::fake-bucket" }
  }

  override_data {
    target = data.aws_caller_identity.current
    values = { account_id = "123456789012" }
  }

  override_module {
    target  = module.network
    outputs = { vpc_id = "vpc-fake" }
  }

Voir : https://developer.hashicorp.com/terraform/language/tests/mocking
