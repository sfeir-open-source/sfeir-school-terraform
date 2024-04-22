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
Il y a plusieurs types de templating utilisable avec Terraform : Terragrunt ou Handlebars.
Terraform propose également son propre modèle de templating (c'est sur celui-ci que nous nous concentrerons)

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

=> *cat cloud_sql/vars.tf*

```hcl-terraform
variable "databases" {
  type = list(
    object({
      name      = string
      charset   = string
      collation = string
    })
  )
}
variable "instance_name" {}
variable "project" {}
```

##==##
<!-- .slide: class="with-code-bg-dark"-->

# Templating

=> *cat cloud_sql/vars.tfvars*

```json
databases = [
    {
        name        = "db_1"
        charset     = "utf8"
        collation   = "utf8_unicode_ci"
        user        = "root"
    },
    {
        name        = "db_2"
        charset     = "latin1"
        collation   = "latin1_swedish_ci"
        user        = "my_app"
    }
]
```

##==##
<!-- .slide: class="with-code-bg-dark"-->

# Templating

=> *cat cloud_sql/main.tf*

```hcl-terraform
resource "google_sql_database" "database" {
  for_each = var.databases
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

* Ce type de template est utilisable depuis la version 0.11, la version 0.12 a introduit quelques nouveautés telles que les blocs dynamiques, les variables conditionnelles, for_each.
* Vous pouvez enchainer les *objets* dans une seule variable sans pour autant créer des objets absoluments identiques.
* Vous pouvez lier la création de modules à l'aide des dépendances implicites et des ID des objets.
* Les variables sont surchargeables.
