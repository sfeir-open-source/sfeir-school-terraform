<!-- .slide: class="with-code-bg-dark"-->

# HCL extended (also known as HIL)

## Dynamic blocks

Certaines resources acceptent des blocs pour leurs configurations. Par exemple, le life cycle d'un bucket GCS ressemblera à ceci :

```hcl-terraform
resource "google_storage_bucket" "auto-expire" {
  name          = "auto-expiring-bucket"
  location      = "EU"

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }
}
```

Ce "lifecycle_rule" n'est pas pas un simple attribut qui accepte un map, mais c'est un "nested block".

Généralement, ces blocs peuvent être présent plusieurs fois dans une même resource (pour définir plusieurs life_cycle_rule dans l'example).

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL extended (also known as HIL)

## Dynamic blocks

Pour générer dynamiquement ces blocs, vous aurez besoin d'écrire des "[Dynamic blocks](https://www.terraform.io/language/expressions/dynamic-blocks)" :

```hcl-terraform
variable "lifecycle_rules" {
  type        = list(
    object({
      age  = number
      type = string
    })
  )
}
```

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL extended (also known as HIL)

## Dynamic blocks (suite)

```hcl-terraform
resource "google_storage_bucket" "auto-expire" {
  name          = "auto-expiring-bucket"
  location      = "EU"

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      condition {
        age = lifecycle_rule.age
      }
      action {
        type = lifecycle_rule.type
      }
    }
  }
}
```

Contrairement à un *for_each* sur une resource, ici, la variable permettant d'accéder aux éléments est le nom du "dynamic block" par défaut (ici: *lifecycle_rule*).

Vous pouvez spécifier un autre nom pour cette variable avec "iterator = *name*"
