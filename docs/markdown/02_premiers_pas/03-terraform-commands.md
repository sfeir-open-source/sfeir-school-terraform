<!-- .slide:-->

# Utilisation

## Terraform init

Cette commande permet d’initialiser le répertoire de travail courant.

* Lit le fichier configuration personnel ~/.terraformrc si existant
* Télécharge les providers et provisioners nécessaires (officiels) sur https://registry.hashicorp.com/
* Instancie le fichier d’état (local ou distant)
* Effectue un “terraform get“ si nécessaire.
* Un fichier *.terraform.lock.hcl* sera automatiquement créé pour garantir l'intégrité des dépendances

Notes:
Cette commande est nécessaire d’être joué dans chaque nouveau dossier mais également lors de l’ajout d’une ressource provenant d’un nouveau provider.

Elle permet également la migration d’un fichier d’état d’un support vers un autre (cf module gestion du fichier d’état).

##==##
<!-- .slide:-->

# Utilisation

## Terraform get

<br/>
Cette commande est utilisée pour télécharger les modules hébergés hors du répertoire courant.

<br/>

Les modules ainsi téléchargés seront stockés dans le dossier “.terraform” du répertoire courant (appelé root module).

##==##
<!-- .slide:-->

# Utilisation

## Terraform plan

Terraform plan va scanner l’ensemble des fichiers *.tf du répertoire courant et comparer le résultat au contenu du fichier d’état (“terraform.tfstate”).

<br/>

Il s’agit d’un dry-run. Aucune modification/écriture ne sera effectuée sur le provider lors du 1er “plan”. Une relecture est faite par la suite pour comparer les états. Terraform vous signalera en cas de modification manuelle des objets référencés dans le fichier d'état.

<br/>

Le résultat peut être exporté en utilisant l’argument “-out” pour une application déportée ou désynchronisée.

<br/>

Terraform ne modifie/crée que les ressources qui nécessitent une modification.

##==##
<!-- .slide:-->

# Utilisation

## Terraform apply

Lors de l'exécution de cette commande, terraform effectue les appels APIs sur le provider pour créer/modifier/supprimer les ressources.

##==##
<!-- .slide:-->

# Utilisation

## Terraform destroy

Terraform destroy décommissionne les ressources présentes (et uniquement) dans le fichier d’état. Il ne modifie pas les ressources dont il n’a pas connaissance.
