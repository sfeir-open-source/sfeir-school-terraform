<!-- .slide: class="transition"-->

# Les langages

##==##
<!-- .slide:-->

# HashiCorp Configuration Language (HCL)

<br/>

https://github.com/hashicorp/hcl

Langage de configuration développé par HashiCorp et ré-utilisé dans ses différents produits. Uniquement déclaratif, il est associé au HIL (HashiCorp Interpolation Language) lorsqu’il faut calculer des valeurs.


##==##
<!-- .slide: -->  

# HashiCorp Configuration Language (HCL)

<br/>

## Mots clefs pour Terraform : 
* **provider, variable, resource, module, output, data**
* Commentaires via # ou /* … */
* Les valeurs sont assignées avec cette syntaxe : `key = value`
* Multi-line via <<EOF … EOF

##==##
<!-- .slide:-->

# HashiCorp Configuration Language (HCL)

<br/>

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

<br/>

## Exemple

```hcl-terraform
provider "google" {
 region = "europe-west1"
}

resource "google_compute_instance" "instance" {
 name         = "demo"
 machine_type = "n1-standard-1"
 zone         = "europe-west1-a"
 tags = ["web"]
 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

<br/>

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
<!-- .element: class="big-code" -->

Utilisation : 
```hcl-terraform
num_cpu = var.num_cpu      // préconisé
tags    = "tag:${var.tag}" // avec expansion
```

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

<br/>

## Variables : Custom validation rules

Le developpeur peut imposer aux utilisateurs des contraintes sur la valeur des variables, telles que :
* Un élément présent dans une liste prédéfinie
* Des expressions régulières
* Des formats (date, lowercase, taille d'une chaine de caractères)

Exemple : un identifiant en minuscule de plus de 4 lettres
```
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

<br/>

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

<br/>

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
<!-- .element: class="big-code" -->

Utilisation :
```hcl-terraform
resource "..." "..." {
  instance_names = [local.instance_names]
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

<br/>

## Provider

Le provider fournit un ensemble de primitives permettant de lire, créer, modifier ou supprimer des ressources sur la plateforme distante.
* Chaque provider possède ses propres attributs
* Il est possible d’utiliser plusieurs déclarations d’un même provider en utilisant l’attribut spécial “alias” (appelé meta-parameter).
* Les variables utilisées pour configurer les providers doivent être calculables avant un plan
* Il est fortement conseillé d'utiliser des variables d'environnement pour configurer les providers

<!-- .element: class="big-code" -->

##==##

# HashiCorp Configuration Language (HCL)

<br/>

## Provider

* Exemple :

Il est possible de configurer le provider Google Cloud en utilisant du HCL ou des variables d'environnement :


```hcl-terraform
provider "google" {
 credentials = "${file("account.json")}"
 project     = "my-project-id"
 region      = "us-central1"
}
```

équivaut à :

```
export GOOGLE_APPLICATION_CREDENTIALS="account.json"
export GOOGLE_PROJECT="my-project-id"
export GOOGLE_REGION="us-central1"
```

<!-- .element: class="big-code" -->

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

<br/>

## Resource
Les ressources sont les composantes de l’infrastructure. 
Elles peuvent être une instance, un loadbalancer, une règle firewall, etc, …<br/>
Elles doivent respecter la syntaxe : resource "TYPE" "NAME”

```hcl-terraform
resource "google_compute_firewall" "default" {
 name    = "test-firewall"
 network = google_compute_network.default.name

 allow {
   protocol = "icmp"
 }
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide:-->

# HashiCorp Configuration Language (HCL)

<br/>

## Resource - Meta parameters

* **count** : Permet de créer plusieurs fois la ressource. count.index permet de récupérer l’index courant
* **for_each** : Pour créer plusieurs fois une ressource en utilisant une map ou une liste de strings (depuis 0.12 à privilégier par rapport à count)
* **lifecycle** : Permet de modifier le cycle de vie de la ressource
* **depends_on** : Forcer une dépendance
* **provider** : Permet de surcharger le provider de la ressource
* **timeouts** : Configurer les timeouts des opérations de création, modification et suppression
* **provisioner** : Permet d'exécuter des scripts en local ou à distance

Notes:
Example :

lifecycle : Permet de modifier le cycle de vie de la ressource (créer la nouvelle avant de supprimer l’ancienne, ignorer les changements d’un attributs, ...)

depends_on : Forcer une dépendance. Par défaut toute “variable interpolée” crée une dépendance implicite. Dans certains cas, il est necessaire d’expliciter la dépendance (exemple, créer une base de donnée avant le serveur d’application).

provider : Permet de surcharger le provider de la ressource par exemple lors de l’utilisation d’alias sur plusieurs providers.

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

<br/>

## Output

Les outputs sont affichés en surbrillance à la fin du déploiement Terraform. 

Ils permettent aux utilisateurs d’afficher des attributs calculés ou retournés par le provider.
<br/>
<br/>
```hcl-terraform
output "addresses" {
 value = [aws_instance.web.*.public_dns]
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HashiCorp Configuration Language (HCL)

<br/>

## Data source

Le data source permet de récupérer des attributs non gérés par Terraform, et donc en lecture seule.

```hcl-terraform
data "google_compute_image" "my_image" {
 family  = "debian-9"
 project = "debian-cloud"
}

[...]
image = "${data.google_compute_image.my_image.self_link}"
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide:-->

# HashiCorp Configuration Language (HCL)

<br/>

## Module

**Un module est un ensemble de ressources.**  
Il permet d’abstraire un déploiement plus complexe et agit comme une boîte noire pour laquelle on utilisera des **variables** en entrée et des **outputs** en sortie.

**Le module permet une réutilisation du code et peut être stocké dans un repository distant (ex: git)(privé ou publique).**

##==##
<!-- .slide:-->

# Terraform settings

Il existe un "block" hors de toute ressource pour définir le comportement du déploiement :
* Forcer les versions à utiliser
* Configurer le backend
* Activer des fonctionnalitées expérimentales

```
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source = "hashicorp/aws"
    }
  }
  backend "remote" {
    organization = "example_corp"
    workspaces {
      name = "my-app-prod"
    }
  }
  experiments = [something]
}
```


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Comment assigner des valeurs aux variables lors de l'exécution d’une action terraform (plan, apply ou destroy) ?

<br/>

1. terraform <action> -var ‘key=value’
2. terraform <action> -var-file ‘path_to_file’
3. export KEY=value; terraform \<action>
4. export TF_VAR_key=value; terraform \<action>
5. en ajoutant un fichier *.auto.tfvars dans le répertoire courant

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Comment assigner des valeurs aux variables lors de l'exécution d’une action terraform (plan, apply ou destroy) ?

<br/>

1. **terraform <action> -var ‘key=value’**
2. **terraform <action> -var-file ‘path_to_file’**
3. export KEY=value; terraform \<action>
4. **export TF_VAR_key=value; terraform \<action>**
5. **en ajoutant un fichier *.auto.tfvars dans le répertoire courant**

Attention, l’ordre des variables à une importance. Les CLI sont toujours prioritaires. En cas de conflit, le dernier argument prévaut (sauf dans le cas d’une map où les clefs différentes sont fusionnées)


Notes:
Values passed within definition files or with -var will take precedence over TF_VAR_ environment variables, as environment variables are considered defaults.

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : A quoi sert la chaîne de caractères qui suit le type d’une ressource ?

<br/>

1. à définir le “display name” de l’objet créé sur la plateforme
2. à identifier la ressource pour la manipuler dans Terraform
3. ce n’est pas encore utilisé
4. à remplacer l’UID de la ressources si elle est définie

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : A quoi sert la chaîne de caractères qui suit le type d’une ressource ?

<br/>

1. à définir le “display name” de l’objet créé sur la plateforme
2. **à identifier la ressource pour la manipuler dans Terraform**
3. ce n’est pas encore utilisé
4. à remplacer l’UID de la ressources si elle est définie


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quel est le comportement de Terraform lors du prochain apply si une ressource a été commentée depuis le dernier apply ?

<br/>

1. Rien, il n’y a pas de changement des attributs
2. Terraform va supprimer la ressource
3. Terraform va ignorer la ressource
4. Une erreur à la compilation

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quel est le comportement de Terraform lors du prochain apply si une ressource a été commentée depuis le dernier apply ?

<br/>

1. Rien, il n’y a pas de changement des attributs
2. **Terraform va supprimer la ressource**
3. Terraform va ignorer la ressource
4. Une erreur à la compilation

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quelle est la particularité d'une variable de type *object* ?

<br/>

1. Le résultat est toujours ordonné
2. Ce n'est pas la plus utilisée
3. Peut contenir de nombreux types différents

##==##
<!-- .slide: -->

# QUIZZ

<br/>

*Question* : Quelle est la particularité d'une variable de type *object* ?

<br/>

1. Le résultat est toujours ordonné
2. Ce n'est pas la plus utilisée
3. **Peut contenir de nombreux types différents**

##==##
<!-- .slide: class="exercice" -->

# Premier déploiement d’infrastructure
 
## Atelier

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL-extended

Avant le version 0.12, Terraform était composé de deux langages :
* le **HCL** (HashiCorp Configuration Language) pour la déclaration des resources, les inputs, les outputs, ...
* le **HIL** (HashiCorp Interpolation Language) pour permettre aux utilisateurs de manipuler la donnée (utilisation de variable, modification de la casse, création de liste, ..).


Depuis la version 0.12, HCL et HIL ont fusionné.


##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL-extended


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

<br/>

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

<br/>

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

<br/>

## Boucles

Terraform permet de déployer plusieurs ressources de même type via une unique déclaration en utilisant le “meta parameter" for_each(ou count).<br/>

![h-400 center](./assets/images/hil_boucle.png)

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL extended (also known as HIL)

<br/>

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

<br/>

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

<br/>

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

Ce "lifecycle_rule" n'est pas pas un simple attribut qui accepte un map, mais c'est un "bloc".

Généralement, ces blocs peuvent être présent plusieurs fois dans une même resource (pour définir plusieurs life_cycle_rule dans l'example).


##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL extended (also known as HIL)

<br/>

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

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Il est possible d’utiliser le meta parameter “for_each” sur les modules.

<br/>

1. Vrai
2. Faux

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Il est possible d’utiliser le meta parameter “for_each” sur les modules.

<br/>

1. **Vrai** (avec Terraform 0.13 disponible depuis le 10 août 2020)
2. ~~**Faux**~~

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Comment obtenir un élément d’une liste ?

<br/>

1. var.list[position]
2. element(var.list, position)
3. list[position]
4. lookup(var.list, position)

##==##
<!-- .slide:-->

# QUIZZ

<br/>

Question : Comment obtenir un élément d’une liste ?

<br/>

1. **var.list[position]**
2. **element(var.list, position)**
3. list[position]
4. lookup(var.list, position)

##==##
<!-- .slide: class="exercice" -->

# Utilisation avancée des interpolations
 
## Atelier
