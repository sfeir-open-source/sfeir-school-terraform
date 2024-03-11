<!-- .slide:-->

# HCL extended (also known as HIL)

## Boucles

Terraform permet de déployer plusieurs ressources de même type via une unique déclaration en utilisant le “meta-argument" for_each(ou count).<br/>

![h-400 center](./assets/images/hil_boucle.png)

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL extended (also known as HIL)

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
<!-- .element: class="big-code" -->