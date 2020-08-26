<!-- .slide: class="transition"-->

# Travail coopératif

##==##
<!-- .slide:-->

# Modules

<br/>

* Les modules favorisent la réutilisation du code en fournissant aux développeurs une bibliothèque de déploiements pré-développés.
* Un module est composé :
  * de variables en entrée
  * d’outputs en sortie
* Il ne sera pas possible pour un utilisateur d’un module d’accéder au contenu du module s’il n’a pas été exposé via un output.



##==##
<!-- .slide:-->

# Modules

## Module Registry

Il existe par défaut plusieurs plateformes permettant de publier des modules tel que github, gitlab, bitbucket, etc… 
<br/>
https://www.terraform.io/docs/modules/sources.html
<br/>

Lorsque ceux-ci seront déclarés dans un fichier de configuration, Terraform les téléchargera à l’aide de la commande : **terraform init** ou **terraform get** et seront stockés localement dans le dossier **.terraform**.
<br/>
L’utilisation de **terraform init --upgrade** permet la mise à jours des modules existants.
<br/>

Hashicorp met à disposition un ensemble de modules officiels sur sa propre registry : https://registry.terraform.io/ 


##==##
<!-- .slide: class="with-code-bg-dark" -->

# Modules

<br/>

=> *cat gke.tf*

```hcl
module "gke-regional" {
 source  = "woernfl/gke-regional/gcp"
 version = "2.0.1"
 cluster_name                        = "${var.cluster_name}"
 logging_service                     = "${var.logging_service}"
 monitoring_service                  = "${var.monitoring_service}"
 region                              = "${var.region}"
 kube_version                        = "${var.kube_version}"
 daily_maintenance_window_start_time = "${var.daily_maintenance_window_start_time}"
 http_load_balancing                 = "${var.http_load_balancing}"
 horizontal_pod_autoscaling          = "${var.horizontal_pod_autoscaling}"
 kubernetes_dashboard                = "${var.kubernetes_dashboard}"
 network_policy_config               = "${var.network_policy_config}"
 node_pools                          = "${var.node_pools}"
}
```

##==##
<!-- .slide:-->

# Modules

## TIPS

* La version d’un module peut être défini par un tag sur le repository
* Bien que la version soit facultatif, son utilisation permet de fiabiliser l’utilisation d’un module dans les déploiements (sans version, le dernier commit est utilisé)
* Il est possible d’inclure des sous-modules
* Il est important d’utiliser les outputs pour obtenir des informations sur les ressources créées
* Les modules héritent des providers par défaut mais il est possible de les surcharger
* Il n’est pas possible d’utiliser le “count” sur les modules


##==##
<!-- .slide:-->

# Gestion de la concurrence et de la persistance

*Le fichier d’état “terraform.tfstate”*

<br/>

* Garder un référentiel des ressources déployées
* Gérer les dépendances entre les ressources
* Format json
* Automatiquement généré

##==##
<!-- .slide:-->

# Gestion de la concurrence et de la persistance

*Le fichier d’état “terraform.tfstate”*
 
Ce fichier est critique, en cas de perte, Terraform “oubliera” l’ensemble des ressources qu’il a créé.<br/>
Il est conseillé de ne pas le stocker localement mais sur : 
* Un stockage de fichier type Google Cloud Storage, AWS S3, … et activer les options de versioning
* De restreindre les accès (principe du least privilege) car ce fichier peut contenir des informations sensibles (IP, clef SSH, password, ...)

##==##
<!-- .slide: class="with-code-bg-dark"-->

# Gestion de la concurrence et de la persistance

*Le fichier d’état “terraform.tfstate”*

La configuration et le choix du backend se fait en déclarant un fichier *.tf (exemple backend.tf).

<br/>

```hcl
terraform {
 backend "gcs" {
   project  = "foo"
   bucket  = "foo"
   prefix  = "foo"
 }
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide:-->

 # Gestion de la concurrence et de la persistance

*Le fichier d’état “terraform.tfstate”*


Il est possible de verrouiller le fichier pour éviter les appels concurrents depuis plusieurs sources (non supporté par tous les backend).

<br/>

Terraform propose la commande **terraform force-unlock** si mon déploiement reste verrouillé.

##==##
<!-- .slide:-->

# Manipulation du fichier d’état

*“terraform.tfstate”*

Dans certains cas, il sera nécessaire de le modifier. Pour cela on utilisera la commande : **terraform state verbe resource-path**

<br/>

* terraform state list
* terraform state show
* terraform state rm google_compute_instance.inst
* terraform state mv -state-out=new.tfstate module.current-name module.new-name
* terraform state pull/push
* terraform import resource-path ID

Notes:
Les cas où on modifie le tfstate : 

on ne veut plus manager une ressource via Terraform

on veut renommer une ressource sans devoir la re-créer (base de donnée par exemple)

on veut spliter un workspace devenu trop gros en plusieurs petit workspaces

##==##
<!-- .slide:-->

# Gestion des credentials

Il est possible d’utiliser les variables d’environnement pour fournir aux provider des identifiants. Chaque provider défini ses variables d’environnement.
 
Exemple : 
* GOOGLE_CREDENTIALS 
* GOOGLE_APPLICATION_CREDENTIALS
* VAULT_TOKEN
* AWS_ACCESS_KEY_ID
* ...

##==##
<!-- .slide: class="with-code-bg-dark"-->

# Gestion des credentials 

## Utilisation de Vault

<img style="position:fixed;top:10px;right:30px" src="./assets/images/g419a1b557d_2_152.png">

<br/>

```hcl
data "vault_generic_secret" "rundeck_auth" {
 path = "secret/rundeck_auth"
}

provider "rundeck" {
 url        = "http://rundeck.example.com/"
 auth_token = "${data.vault_generic_secret.rundeck_auth.data["auth_token"]}"
}
```
<!-- .element: class="big-code" -->

_Attention, les attributs retournés par un data source apparaissent dans le fichier d’état (terraform.tfstate)_

##==##
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
<!-- .slide: -->

# Templating
Bien que de nombreux modules soient disponibles dans le registry Terraform, certains peuvent ne pas être compatible avec ce que vous souhaitez déployer.  
Dans ce cas, il est recommandé de créer vos propres modules.  
De plus, cela peut convenir a certaines bonnes pratiques telles que :
- Le templating
- Les dépendances implicites
- Les **child-resources**

Notes: 
Les child resources sont des resources ayant besoin d'une autre ressource pour être déployées.

##==##
<!-- .slide: -->

# Templating
Voici deux manières de créer un template de ressource : 

A l'aide de **count**
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
<!-- .slide: -->

# Templating
A l'aide de **for_each**
```hcl
resource "google_sql_database" "database" {
  for_each = {
    name    = "db_"
    project = "project_"    
  }
  instance  = "xxx"
  name      = each.key
  project   = each.value
  charset   = "xxx"
  collation = "xxx"
  provider  = "xxx"
}
```

##==##
<!-- .slide: -->

# Templating

## TIPS 

* Ce type de template est utilisable depuis la version 0.11, la version 0.12 a introduit quelques nouveautés telles que les blocs dynamiques, les variables conditionnelles, for_each.
* Vous pouvez enchainer les *objets* dans une seule variable sans pour autant créer des objets absoluments identiques.
* Vous pouvez lier la création de modules à l'aide des dépendances implicites et des ID des objets.
* Les variables sont surchargeables.

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quel est le comportement de Terraform lorsqu’une ressource est supprimée manuellement ?

<br/>

1. Error 404
2. Rien
3. Terraform propose de recréer la ressource


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quel est le comportement de Terraform lorsqu’une ressource est supprimée manuellement ?

<br/>

1. Error 404
2. Rien
3. **Terraform propose de recréer la ressource**


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Que fait la commande :	terraform state rm <resource-path>

<br/>

1. Elle supprime du code la ressource
2. Elle retire la ressource de ton fichier d’état
3. Elle supprime l’objet créé
4. La commande n’existe pas


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Que fait la commande :	terraform state rm <resource-path>

<br/>

1. Elle supprime du code la ressource
2. **Elle retire la ressource de ton fichier d’état**
3. Elle supprime l’objet créé
4. La commande n’existe pas


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Comment obtenir la valeur d’un attribut d’un ressource créée dans un module ?

<br/>

1. En utilisant “${module.<name>.<output-name>}”
2. En utilisant “${module.<name>.<resource-type>.<name>.<attribut>}”


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Comment obtenir la valeur d’un attribut d’un ressource créée dans un module ?

<br/>

1. **En utilisant “${module.<name>.<output-name>}”**
2. En utilisant “${module.<name>.<resource-type>.<name>.<attribut>}”

##==##
<!-- .slide: class="exercice" -->

# Création d’un registre de module dans gitlab
 
## Atelier


