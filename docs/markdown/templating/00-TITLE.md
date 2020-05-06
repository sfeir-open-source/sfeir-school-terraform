<!-- .slide: class="transition" -->

# Templating

##==##

# Templates

<br/>

* Les templates favorisent la mise en forme du code en utilisant des fichiers de variables .tfvars qui seront chargés par Terraform au runtime (plan ou apply).
* Le fichier .tfvars peut contenir:
  * des variables simples
  * des listes
  * des maps
  * des listes de map ou des listes de listes
* La variable doit être définie "vide" dans le fichier de variable.
* Il y a plusieurs types de templating utilisable avec Terraform : 
  * Terragrunt
  * Handlebars
  * terraform propose également son propre modèle de templating (c'est sur celui-ci que nous nous concentrerons)


##==##
<!-- .slide: -->

# Templates

## Modules

Dans la partie précédente, nous avons vu comment appeler un module stocké sur un repo.
Cependant, il est possible que le module que vous souhaitez utiliser ne réponde pas entièrement à vos besoin. Dans ces cas là, il devient necéssaire de créer votre propre module.
Une fois le module créé, vous pouvez le conserver en local ou bien le publier sur votre propre repo.

##==##
<!-- .slide: class="with-code-bg-dark" -->

# Templates

=> *cat cloud_sql/main.tf*
```hcl
resource "google_sql_database" "database" {
  count     = length(var.database)
  provider  = "google-beta"
  instance  = element(var.instance_name, lookup(var.database[count.index], "instance_id"))
  name      = lookup(var.database[count.index], "name")
  charset   = lookup(var.database[count.index], "charset", null)
  collation = lookup(var.database[count.index], "collation", null)
  project   = var.project
}
```

##==##
<!-- .slide:-->

# Templates

=> *cat cloud_sql/vars.tf*
```hcl
variable "database" {
  type = list
}
variable "instance_name" {}
variable "project" {}
```

##==##
<!-- .slide:-->

# Templates

=> *cat cloud_sql/vars.tfvars*
```json
database = [
    {
        id          = "0"
        instance_id = "0"
        name        = "db_1"
        charset     = "utf8"
        location    = "xxxx"
    }
]
```

##==##
<!-- .slide:-->

# Templates

## TIPS

* Ce type de template est utilisable depuis la version 11, la version 12 a ajouté quelques nouveauté comme les blocs dynamiques et les variables conditionnelles.
* Vous pouvez enchainer les *objets* dans une seule variable sans pour autant créer des objets absoluments identiques.
* Vous pouvez lier la création de modules à l'aide des dépendances implicites et les ID des objets.
* Les variables sont surchargeable.
* Le count est défini dans le module.

##==##
<!-- .slide: -->

# QUIZZ

<br/>

*Question* : Comment est géré le *count* ?

<br/>

1. Rien
2. Relancer plusieurs fois terraform
3. Directement dans le fichier .tfvars

##==##
<!-- .slide: -->

