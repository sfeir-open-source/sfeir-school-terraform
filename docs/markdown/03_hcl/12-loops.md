<!-- .slide: class="with-code-bg-dark"-->

# HCL Extended

## Boucles

Terraform permet de déployer plusieurs ressources de même type via une unique déclaration en utilisant le “meta-argument" for_each(ou count).<br>
```hcl-terraform
resource "google_compute_instance" "inst" {
  count        = var.instance_count
  name         = "server-${count.index}"
  machine_type = "e2-micro"
  zone         = "us-central1-a"
}
```
![h-300 center](./assets/images/hil_boucle.png)

##==##

<!-- .slide: class="with-code-bg-dark"-->

# HCL Extended

## Boucles

Depuis la version 0.12, Terraform a introduit une nouvelle manière d’itérer **For-Each** (à privilégier par rapport à count).

```hcl-terraform
resource "vault_ldap_auth_backend_group" "group-users" {
  for_each  = local.bindings
  groupname = each.key
  policies  = tolist(keys(each.value))
  backend   = vault_ldap_auth_backend.ldap.path
}
```
Notes: 
Idéalement, il faudrait créer une variable locale dédiée pour gérer les listes de policies pour chaque groupe => simplifier la lisibilité du code