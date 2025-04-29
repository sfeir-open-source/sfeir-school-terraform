<!-- .slide: class="with-code-bg-dark"-->

# HCL Extended

## Boucles

Terraform permet de déployer plusieurs ressources de même type via une unique déclaration en utilisant le “meta-argument" `for_each` (ou `count`).
<br>

![h-400 center](./assets/images/hil_boucle.png)

##==##

<!-- .slide: class="with-code-bg-dark"-->

# HCL Extended

## Boucles

Depuis la version 0.12, Terraform a introduit une nouvelle manière d’itérer `for_each` (à privilégier par rapport à count).

```hcl-terraform
resource "google_storage_bucket" "buckets" {
  for_each = {
    "logs-bucket"    = "STANDARD"
    "website-bucket" = "NEARLINE"
  }

  name          = each.key
  location      = "EU"
  storage_class = each.value
}
```
Notes:
Idéalement, il faudrait créer une variable locale dédiée pour gérer les listes de policies pour chaque groupe => simplifier la lisibilité du code
