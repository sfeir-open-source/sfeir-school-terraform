<!-- .slide: class="with-code-bg-dark"-->

# HCL-extended
##
Avant la version 0.12, Terraform était composé de deux langages :
* le **HCL** (HashiCorp Configuration Language) pour la déclaration des resources, les inputs, les outputs, ...
* le **HIL** (HashiCorp Interpolation Language) pour permettre aux utilisateurs de manipuler la donnée (utilisation de variable, modification de la casse, création de liste, ..).


Depuis la version 0.12, HCL et HIL ont fusionné.


##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL-extended
##
Il est possible de manipuler des variables, récupérer des attributs d’autres ressources ou utiliser des fonctions native directement dans notre code :

```hcl-terraform
data "template_file" "example" {
 template = file("templates/greeting.tpl")
 vars {
   hello = "goodnight"
   world = "moon"
 }
}
```

Usage
```hcl-terraform
resource "aws_instance" "web" {
  ami              = "ami-d05e75b8"
  instance_type    = "t2.micro"
  user_data_base64 = data.template_file.example.rendered
}
```

Il reste néanmoins possible (mais déprécié) d'utiliser l'ancien format via l'utilisation de `"${ ... }"`

Par exemple : `"${data.template_file.example.rendered}"`

<!-- .element: class="big-code" -->

##==##
<!-- .slide:-->

# HCL extended (also known as HIL)

## Lier les attributs

Il est possible de lire la valeur d’un attribut d’une ressource, d’une source de donnée, d’une variable, …
* resource : `resource_type.resource_name.attribut`
* variable : `var.variable_name`
* module : `module.module_name.output_name`
* data source : `data.data_type.data_name.attribut`

Cas d’une liste de resource : `resource_type.resource_name[<index>].attribut`


##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL extended (also known as HIL)

Il existe de nombreuses fonctions [documentées en ligne](https://www.terraform.io/docs/language/functions/index.html).

Exemple d’utilisation :

```hcl-terraform
  count     = length(var.shortnames)
  upper-foo = upper(var.foo)
  encoded   = base64encode(var.sensitive_content)
```
<!-- .element: class="big-code" -->

##==##
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

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL extended (also known as HIL)

## Conditions

Les conditions permettent de définir des valeurs différentes en fonction des variables ou d’autres attributs.

```hcl-terraform
resource "google_compute_instance" "web" {
   machine_type = var.env == "production" ? var.prod_size : var.dev_size
}
```

##==##
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

Ce "lifecycle_rule" n'est pas pas un simple attribut qui accepte un map, mais c'est un "block".

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
<!-- .element class="big-code" -->
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
