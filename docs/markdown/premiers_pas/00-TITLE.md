<!-- .slide: class="transition"-->

# Premiers pas avec Terraform

##==##
<!-- .slide:  -->
# Installation

<br/>

**0 installation, CLI pré-compilé**

<br/>

1. Téléchargement du binaire => https://www.terraform.io/downloads.html
3. Utilisation

<br/>

⇒ Déjà pré-installé dans le Google Cloud Shell


![w-1000 center](./assets/images/g418fd663c2_0_272.png)

Notes:
Plusieurs manières d'installer Terraform.
En le téléchargeant depuis le site officiel ou via l'utilisation de tf_env.
Le logiciel est sous la forme d’un binaire (pré-compilé pour différents OS).
Sur GCP, la toute dernière version est disponible sur le Cloud Shell, sur Azure et AWS, il n'est pas installé.

##==##

# Utilisation

## Workflow

![w-1000 center](./assets/images/workflow.png)

##==##
<!-- .slide:-->

# Utilisation

## Terraform init

Cette commande permet d’initialiser le répertoire de travail courant.

* Lit le fichier configuration personnel ~/.terraformrc si existant 
* Télécharge les providers et provisioners nécessaires (officiels) sur https://releases.hashicorp.com/
* Instancie le fichier d’état (local ou distant)
* instancie ou télécharge les modules déclarés (Effectue un “terraform get“ si nécessaire.)

Notes:
Cette commande est nécessaire d’être jouée dans chaque nouveau dossier mais également lors de l’ajout d’une ressource provenant d’un nouveau provider.
Elle permet également la migration d’un fichier d’état d’un support vers un autre (cf module gestion du fichier d’état).

##==##
<!-- .slide:-->

# Utilisation

## Terraform get

<br/>
Cette commande est utilisée pour télécharger les modules hébergés hors du répertoire courant.

<br/>

Les modules ainsi téléchargés seront stocké dans le dossier “.terraform” du répertoire courant (appelé root module).

##==##
<!-- .slide:-->

# Utilisation

## Terraform plan

Terraform plan va scanner l’ensemble des fichiers *.tf du répertoire courant et comparer le résultat au contenu du fichier d’état (“terraform.tfstate”).

<br/>

Il s’agit d’un dry-run. Aucune modification/lecture ne sera effectuée sur le provider lors du 1er “plan”. Une relecture est fait par la suite pour comparer les états.

<br/>

Le résultat peut être exporté en utilisant l’argument “-out” pour une application déportée ou désynchronisée.

<br/>

Terraform ne modifie/crée que les ressources qui nécessitent une modification.

Notes:
Terraform plan juge principalement la syntaxe ainsi que certaines variables et retournera une erreur si tout ne semble pas conforme.

##==##
<!-- .slide:-->

# Utilisation

## Terraform apply

Lors de l'exécution de cette commande, terraform effectue les appels APIs sur le provider pour créer/modifier/supprimer les ressources

##==##
<!-- .slide:-->

# Utilisation

## Terraform destroy

Terraform destroy décommissionne les ressources présentes (et uniquement) dans le fichier d’état. Il ne modifie pas les ressources dont il n’a pas connaissance.

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quel est le langage de programmation utilisé dans Terraform ?

<br/>

1. C++
2. Java
3. Golang
4. PHP

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quel est le langage de programmation utilisé dans Terraform ?

<br/>

1. C++
2. Java
3. **Golang**
4. PHP


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quelle commande est utilisée pour afficher le graphe de dépendance construit par Terraform lors de son exécution ?
1. terraform plan -out graph.png -format png
2. terraform graph -draw-cycles | dot -Tpng > graph.png
3. terraform show -ascii-art
4. terraform output -graph > graph.png

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quelle commande est utilisée pour afficher le graphe de dépendance construit par Terraform lors de son exécution ?

1. terraform plan -out graph.png -format png
2. **terraform graph -draw-cycles | dot -Tpng > graph.png**
3. terraform show -ascii-art
4. terraform output -graph > graph.png

##==##
<!-- .slide: class="exercice" -->

# Installation et configuration
 
## Atelier

