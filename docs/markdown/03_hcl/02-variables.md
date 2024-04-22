<!-- .slide:-->

# HashiCorp Configuration Language (HCL)

## Type de variables

HCL a de nombreux types de variable comme :

* String via “...”
* Nombre
* Booléen
* List via `[ … ]`
* Map via `{ ... }`
* Structure anonyme (object)
* Type complexe (list de map, map de list, map de map de map, …)

Notes:
Contrairement à la map, tous les champs d'un object sont de même type

##==##

<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

## Variables

Les variables permettent d’adapter les attributs en fonction de différents critères comme l’environnement, le type d’application, etc…

Déclaration :

```hcl-terraform
variable "num_cpu" {
 type = number
 description = "This variable define the number of CPU"
 default = 2
}
```

Utilisation :

```hcl-terraform
num_cpu = var.num_cpu      // préconisé
tags    = "tag:${var.tag}" // avec expansion
```

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

## Variables : Custom validation rules

Le developpeur peut imposer aux utilisateurs des contraintes sur la valeur des variables, telles que :

* Un élément présent dans une liste prédéfinie
* Des expressions régulières
* Des formats (date, lowercase, taille d'une chaine de caractères)

Exemple : un identifiant en minuscule de plus de 4 lettres

```hcl-terraform
variable "id" {
  type        = string
  description = "Primary ID used for the user"

  validation {
    condition     = length(var.id) > 4 && lower(var.id) == var.id
    error_message = "Require at least 4 characters in lower case."
  }
}
```

##==##
<!-- .slide: class="with-code-bg-dark" -->
# HashiCorp Configuration Language (HCL)

## Variables : le récap

Les variables supportent les attributs suivant :

* **default** : assigne une valeur par défaut qui peut être surchargée
* **type** : définit le type de la variables (par défaut string mais il est possible d'utiliser des variables de type bool, map, list, ...)
* **description** : aide l'utilisateur à définir le contenu de la variable
* **validation** : permet de rejeter une valeur si elle ne respecte pas les conditions
* **sensitive** : interdit l'affichage de la valeur au travers d'outputs et masque son contenu dans la console

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

## Variables locales

Une `local` est l'association d'une expression à une variable, afin d'être réutilisée plusieurs fois dans un module.

Déclaration :

```hcl-terraform
locals {
  # Simple string
  region = "europe-west4"
  # List
  instance_names = ["inst-a", "inst-b"]
  # Ids for multiple sets of EC2 instances, merged together
  instance_ids = concat(aws_instance.blue.*.id, aws_instance.green.*.id)
}
```

Utilisation :

```hcl-terraform
resource "..." "..." {
  instance_names = [local.instance_names]
}
```
