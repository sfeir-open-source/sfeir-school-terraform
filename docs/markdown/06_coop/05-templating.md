<!-- .slide:-->

# Templating

* Les templates favorisent la mise en forme du code en utilisant des fichiers de variables .tfvars qui seront chargés par Terraform au runtime (plan ou apply).
* Le fichier .tfvars peut contenir:
  * des variables simples
  * des listes
  * des maps
  * des listes de map ou des listes de listes
* La variable doit être définie "vide" dans le fichier de variable.

Notes:
Attention au mot "templating", il recouvre deux choses distinctes :
- ici : paramétrer un module via des variables structurées et des fichiers `.tfvars`
- la fonction `templatefile()` (module 3) : rendre un fichier non-Terraform (script, config) en y injectant des valeurs
Ce module traite le premier cas.
Il existe aussi des outils externes de templating autour de Terraform : Terragrunt, Handlebars.

##==##

# Templating

Bien que de nombreux modules soient disponibles dans le registry Terraform, certains peuvent ne pas être compatible avec ce que vous souhaitez déployer (ou trop générique).
Dans ce cas, il est recommandé de créer vos propres modules.
De plus, cela peut convenir a certaines bonnes pratiques telles que :

* Le templating
* Les dépendances implicites
* Les **child-resources**

Notes:
Les child resources sont des resources ayant besoin d'une autre ressource pour être déployées.

##==##
<!-- .slide: class="with-code-bg-dark"-->

# Templating

=> *cat cloud_sql/variables.tf*

```hcl-terraform
variable "databases" {
  type = map(object({
    name      = string
    charset   = string
    collation = string
    user      = string
  }))
}
variable "instance_name" {}
variable "project" {}
```

##==##
<!-- .slide: class="with-code-bg-dark"-->

# Templating

=> *cat cloud_sql/terraform.tfvars*

```hcl-terraform
databases = {
  db_1 = {
    name      = "db_1"
    charset   = "utf8"
    collation = "utf8_unicode_ci"
    user      = "root"
  }
  db_2 = {
    name      = "db_2"
    charset   = "latin1"
    collation = "latin1_swedish_ci"
    user      = "my_app"
  }
}
```

Notes:
`for_each` n'accepte qu'une **map** ou un **set of strings**, jamais une liste. D'où le typage en `map(object({...}))`.
Avec une liste en entrée, il faut la convertir : `for_each = { for db in var.databases : db.name => db }`.
Une map a un autre avantage : les clés sont stables. Avec une liste, supprimer le premier élément décale tous les index et Terraform recrée les ressources suivantes.

##==##
<!-- .slide: class="with-code-bg-dark"-->

# Templating

=> *cat cloud_sql/main.tf*

```hcl-terraform
resource "google_sql_database" "database" {
  for_each  = var.databases
  name      = each.value.name
  instance  = var.instance_name
  project   = var.project
  charset   = each.value.charset
  collation = each.value.collation
}
```

##==##

# Templating

## TIPS

* Les fichiers `.tfvars` existent depuis la 0.11. La 0.12 a introduit les types structurés (`object`), les blocs dynamiques et `for_each` — c’est elle qui rend ce pattern utilisable.
* Vous pouvez enchaîner les *objets* dans une seule variable sans pour autant créer des objets absolument identiques.
* Vous pouvez lier la création de modules à l'aide des dépendances implicites et des ID des objets.
* Les variables sont surchargeables.
