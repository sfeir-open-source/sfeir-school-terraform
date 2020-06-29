<!-- .slide: class="transition"-->

# Les langages

##==##
<!-- .slide:-->

# HashiCorp Configuration Language (HCL)

<br/>

https://github.com/hashicorp/hcl

Langage de configuration développé par HashiCorp et ré-utilisé dans ses différents produits. Uniquement déclaratif, il est associé au HIL (HashiCorp Interpolation Language) lorsqu’il faut calculer des valeurs.

Notes:
Nomad, Packer, Consul et Serf utilisent également le HCL, contrairement à Vagrant.
Le HCL est une combinaison entre la syntaxe déclarative et l'interpolation de variables.


##==##
<!-- .slide: -->  

# HashiCorp Configuration Language (HCL)

<br/>

## Mots clefs pour Terraform : 
* **provider, variable, resource, module, output, data**
* commentaires via # ou /* … */ 
* Multi-line via <<EOF … EOF
* 3 types de variables (terraform 0.11 ou moins) : 
   * **String** via “...”
   * **List** via [ … ]
   * **Map** via { ... }

Notes:
* Ce sont évidemment des mots clefs spécifique à Terraform
* Multi-line : Utilisable dans les ressources de type "policy"

##==##
<!-- .slide:-->

# HashiCorp Configuration Language (HCL)

<br/>

## Depuis la version 0.12

La version 0.12 de terraform introduit de nouveaux types d’objets comme : 
* Nombre
* Booléen
* Structure anonyme (object)
* Type complexe (list de map, map de list, map de map de map, …)

Notes:
Les objets de type "list of map" sont utilisable depuis la version 0.11 mais leur utilisation a été rendue plus simple grâce à l'introduction des blocs dynamique.

##==##
<!-- .slide: -->

# Hashicorp Configuration Language (HCL)

<br/>

## Depuis la version 0.12
La version 0.12 de Terraform a également introduit de nouvelles instructions, telles que : 
* Les blocs dynamique
* Les instructions conditionnelles
* for et for_each

Notes:
Nous verrons en détail chacune de ces instructions plus tard.

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

<br/>

## Exemple


```hcl
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

Notes:
Ici nous déclarons le provider, en l'occurence Google, mais ça aurait pu être Azure, AWS, Openstack ou n'importe quel autre.
Ensuite nous créons un objet manipulable de type Instance, dont l'image de démarrage est une Debian 9, ayant pour identifiant demo, se trouvant dans la zone europe-west1-a, de type n1-standard-1 contenant le tag "web". 
Le processus de création d'objet de même type chez d'autre Provider Cloud est identique, seul les mots clés diffèrent. 

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

<br/>

## Variables

Les variables permettent d’adapter les attributs en fonction de différents critères comme l’environnement, le type d’application, etc…

Déclaration : 

```hcl
variable "num_cpu" {
 type = "string"
 description = "This variable define the number of CPU"
 default = "2"
}
```
<!-- .element: class="big-code" -->

Utilisation : 
```hcl
num_cpu = var.num_cpu
```
<!-- .element: class="big-code" -->

Notes:
Selon les cas, l'utilisation et la gestion des variables sera différent.
Vous pouvez valoriser directement les variables dès leur déclaration et les overrider par la suite (en passant l'option -var de la commande terraform)
Ou les déclarer "à vide" et utiliser un autre fichier (.tfvars) afin de les valoriser (en passant l'option -var-file de la commande terraform)
Ou bien utiliser la fonctionnalité Workspace de terraform, y définir les valeurs spécifique des variables et les réutiliser à la volée par la suite. 



##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

<br/>

## Variables locales 

Déclaration : 
```hcl
locals {
 instance_names = ["inst-a", "inst-b"]
}
```
<!-- .element: class="big-code" -->

Utilisation : 
```hcl
instance_names = ["${local.instance_names}"]
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

<br/>

## Provider

Le provider fournit un ensemble de primitives permettant de lire, créer, modifier ou supprimer des ressources sur la plateforme distante. 
* Chaque provider possède ses propres attributs
* Il est possible d’utiliser plusieurs déclarations d’un même provider en utilisant l’attribut spécial “alias” (appelé meta-parameter)
* Il est possible de forcer une version du provider via l’attribut “version”. Par défaut, terraform utilise la dernière version.

```hcl
provider "google" {
 credentials = "${file("account.json")}"
 project     = "my-project-id"
 region      = "us-central1"
}
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

```hcl
resource "google_compute_firewall" "default" {
 name    = "test-firewall"
 network = "${google_compute_network.default.name}"

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

## Resource - Meta parameters (v0.11)

* **count** : Permet de créer plusieurs fois la ressource. count.index permet de récupérer l’index courant
* **lifecycle** : Permet de modifier le cycle de vie de la ressource 
* **depends_on** : Forcer une dépendance. 
* **provider** : Permet de surcharger le provider de la ressource
* **timeouts** : Configurer les timeouts des opération de création, modification et suppression
* **provisioner** : Permet d'exécuter des scripts en local ou à distance


Notes:
lifecycle : Permet de modifier le cycle de vie de la ressource (créer la nouvelle avant de supprimer l’ancienne, ignorer les changements d’un attributs, ...)
depends_on : Forcer une dépendance. Par défaut toute “variable interpolée” crée une dépendance implicite. Dans certains cas, il est necessaire d’expliciter la dépendance (exemple, créer une base de donnée avant le serveur d’application).
provider : Permet de surcharger le provider de la ressource par exemple lors de l’utilisation d’alias sur plusieurs providers ou bien lorsque certaines ressources ne sont pas disponible sur le driver principal (dans le cas de Google et Google-beta, par exemple).
timeouts : Permet de remplacer les timeouts par défaut

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

<br/>

## Output

Les outputs sont affichées en surbrillance à la fin du déploiement Terraform. 
Elles permettent aux utilisateurs d’afficher des attributs calculés ou retournés par le provider.

```hcl
output "addresses" {
 value = ["${aws_instance.web.*.public_dns}"]
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HashiCorp Configuration Language (HCL)

<br/>

## Data source

Le data source permet de récupérer des attributs non gérés par Terraform.

```hcl
data "google_compute_image" "my_image" {
 family  = "debian-9"
 project = "debian-cloud"
}

[...]
image = data.google_compute_image.my_image.self_link
```
<!-- .element: class="big-code" -->

Notes:
Il est également possible de récupérer des attributs de ressources générés par Terraform et stockée dans un state localement ou sur un backend différent.

##==##
<!-- .slide: -->

# HashiCorp Configuration Language (HCL)

<br/>

```hcl
data "terraform_remote_state" "network" {
  backend = "s3"
  
  config {
    bucket = "networking-terraform"
    key = "vpc-prod01.terraform.tfstate"
    region = "us-east-1"
  }
}
[...]
network = data.terraform_remote_state.network.outputs.name
```

Notes:


##==##
<!-- .slide:-->

# HashiCorp Configuration Language (HCL)

<br/>

## Module

**Un module est un ensemble de ressources.**    
Il permet d’abstraire un déploiement plus complexe et agit comme une boîte noire pour laquelle on utilisera des **variables** en entrée et des **outputs** en sortie.

**Le module permet une réutilisation du code et peut être stocké localement ou dans un repository distant (privé ou publique).**

Notes:
Les modules stockés dans une repository distant sont des remote modules.
Ils peuvent être dans le terraform registry ou dans un repository github privé non reférencé dans le terraform registry.

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Comment assigner des valeurs aux variables lors de l'exécution d’une action terraform (plan, apply ou destroy) ?

<br/>

1. terraform <action> -var ‘key=value’
2. terraform <action> -var-file ‘path_to_file’
3. export KEY=value; terraform <action>
4. export TF_VAR_key=value; terraform <action>
5. en ajoutant un fichier *.auto.tfvars dans le répertoir courant


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Comment assigner des valeurs aux variables lors de l'exécution d’une action terraform (plan, apply ou destroy) ?

<br/>

1. **terraform <action> -var ‘key=value’**
2. **terraform <action> -var-file ‘path_to_file’**
3. **export KEY=value; terraform <action>**
4. **export TF_VAR_key=value; terraform <action>**
5. **en ajoutant un fichier *.auto.tfvars dans le répertoir courant**

Attention, l’ordre des variables à une importance. Les CLI sont toujours prioritaires. En cas de conflit, le dernier argument prévaut (sauf dans le cas d’une map où les clefs différentes sont fusionnées)


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

*Question* : Quel est le comportement de Terraform lors du prochain apply si une ressource à été commenté depuis le dernier apply ?

<br/>

1. Rien, il n’y a pas de changement des attributs
2. Terraform va supprimer la ressource
3. Terraform va ignorer la ressource
4. Une erreur à la compilation


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quel est le comportement de Terraform lors du prochain apply si une ressource à été commenté depuis le dernier apply ?

<br/>

1. Rien, il n’y a pas de changement des attributs
2. **Terraform va supprimer la ressource**
3. Terraform va ignorer la ressource
4. Une erreur à la compilation

##==##
<!-- .slide: class="exercice" -->

# Premier déploiement d’infrastructure
 
## Atelier

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HashiCorp Interpolation Language (HIL)
 
https://github.com/hashicorp/hil

Le Langage permet de manipuler des variables ou récupérer des attributs d’autres ressources.L’interpolation doit être déclarée entre “${ ... }” 

```hcl
data "template_file" "example" {
 template = file("templates/greeting.tpl")
 vars {
   hello = "goodnight"
   world = "moon"
 }
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide:-->

# HashiCorp Interpolation Language (HIL)

<br/>

## Lier les attributs

Il est possible de lire la valeur d’un attribut d’une ressource, d’une source de donnée, d’une variable, …
* resource : `resource_type.resource_name.attribut`
* variable : `var.variable_name`
* module : `module.module_name.output_name`
* data source : `data.data_type.data_name.attribut`

Cas d’une liste de resource (version < 0.12) : `resource_type.resource_name.*.attribut[<index>]`


##==##
<!-- .slide: class="with-code-bg-dark"-->

# HashiCorp Interpolation Language (HIL)

<br/>

Exemple d’utilisation des fonctions :

```hcl
  count     = "${length(var.shortnames)}"
  upper-foo = "${upper(var.foo)}"
  lower-foo = "${lower(var.foo)}"
```  
<!-- .element: class="big-code" -->

##==##
<!-- .slide:-->

# HashiCorp Interpolation Language (HIL)

<br/>

## Boucles

Terraform permet de déployer plusieurs ressources de même type via une unique déclaration en utilisant le “meta parameter" count.<br/>
Attention, les boucles ne sont disponibles que pour les ressources et data sources

![h-400 center](./assets/images/hil_boucle.png)

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HashiCorp Interpolation Language (HIL)

<br/>

## Boucles

Depuis la version 0.12, Terraform a introduit deux nouvelles manière d’itérer **For and For-Each**

```hcl
resource "vault_ldap_auth_backend_group" "group-users" {                                                                
  for_each  = local.bindings                                                                                            
  groupname = each.key                                                                                                  
  policies  = tolist(keys(each.value))                                                                                  
  backend   = vault_ldap_auth_backend.ldap.path                                                                          
}
```
<!-- .element: class="big-code" -->

<br/>

https://hashicorp.com/blog/hashicorp-terraform-0-12-preview-for-and-for-each

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HashiCorp Interpolation Language (HIL)

<br/>

## Conditions

Les conditions permettent de définir des valeurs différentes en fonction des variables ou d’autres attributs

```hcl
resource "google_compute_instance" "web" {
   machine_type = "${var.env == "production" ? var.prod_size : var.dev_size}"
}
```
<!-- .element: class="big-code" -->

**Avant Terraform 0.12, seul le type string était supporté comme valeur de retour.** 

```hcl
inputs = {
   v011 = "${element(split(",", "foo"=="foo" ? join(",", list("")) : join(",", list(""))), 0)}"
   v012 = "${element("foo"=="foo" ? list("") : list(""), 0)}"
 }
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Il est possible d’utiliser le meta parameter “count” sur les modules.

<br/>

1. Vrai
2. Faux

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Il est possible d’utiliser le meta parameter “count” sur les modules.

<br/>

1. Vrai
2. **Faux**


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
